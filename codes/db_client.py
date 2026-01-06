# db_client.py
import psycopg2
import config

class DatabaseClient:
    def __init__(self):
        try:
            self.conn = psycopg2.connect(**config.DB_CONFIG)
            self.conn.autocommit = True
            print("✅ Connexion BDD réussie.")
        except Exception as e:
            print(f"❌ Erreur connexion BDD : {e}")
            self.conn = None

    def get_location_id(self, ville_nom):
        if not self.conn: return None
        # Gestion des accents pour Dusseldorf/Düsseldorf
        ville_clean = ville_nom.replace("ü", "u")
        with self.conn.cursor() as cur:
            cur.execute("SELECT PK_LOCATIONS FROM locations_names WHERE NAME ILIKE %s", (f"%{ville_clean}%",))
            res = cur.fetchone()
            return res[0] if res else None

    def get_travel_time(self, id_dep, id_arr):
        """Récupère le temps (en heures) depuis la matrice"""
        if not self.conn: return 0
        with self.conn.cursor() as cur:
            # Sélection dynamique de la colonne "0", "1", etc.
            query = f'SELECT "{id_arr}" FROM travel_time_matrix WHERE FK_LOCATIONS = %s'
            cur.execute(query, (id_dep,))
            res = cur.fetchone()
            return float(res[0]) if res and res[0] is not None else 0

    def get_my_trucks(self):
        """Récupère les camions (WEST-EU)"""
        trucks = []
        if not self.conn: return []
        with self.conn.cursor() as cur:
            for ville in config.VILLES_OUEST:
                id_ville = self.get_location_id(ville)
                if not id_ville: continue
                
                # 1. Plages ID
                cur.execute("SELECT REF_L, REF_H FROM assigned_trucks WHERE FK_LOCATIONS = %s", (id_ville,))
                plages = cur.fetchall()
                
                # 2. Détails camions
                for (ref_min, ref_max) in plages:
                    query = """
                        SELECT REFERENCE, PTAC, ENERGIE, REMORQUE_REFRIGEREE, COULEUR 
                        FROM trucks 
                        WHERE REFERENCE BETWEEN %s AND %s
                    """
                    cur.execute(query, (ref_min, ref_max))
                    rows = cur.fetchall()
                    for row in rows:
                        trucks.append({
                            "REF": row[0],
                            "PTAC": row[1],
                            "ENERGIE": row[2],
                            "FRIGO": row[3] == 1,
                            "LOC": ville
                        })
        return trucks
    
    def get_truck_capacity(self, ptac):
        """Récupère la capacité max palettes selon PTAC"""
        if not self.conn: return 33
        with self.conn.cursor() as cur:
            # On prend la colonne EPAL par défaut comme référence max
            cur.execute("SELECT EPAL FROM trucks_capacity WHERE PTAC = %s", (ptac,))
            res = cur.fetchone()
            return res[0] if res else 33

    def get_consommation(self, ptac, energie):
        """Récupère la conso aux 100km"""
        if not self.conn: return 30.0
        # Mapping des colonnes de la table trucks_consumption
        col_map = {
            "Diesel": "DIESEL (L)", "Essence": "GASOLINE (L)", 
            "GPL": "LPG (kg)", "Electrique": "ELECTRIC (kWh)", "Hydrogène": "HYDROGEN (kg)"
        }
        col = col_map.get(energie, "DIESEL (L)")
        
        with self.conn.cursor() as cur:
            query = f'SELECT "{col}" FROM trucks_consumption WHERE PTAC = %s'
            cur.execute(query, (ptac,))
            res = cur.fetchone()
            return float(res[0]) if res else 30.0

    def insert_log(self, data):
        """
        Insertion conforme à la NOUVELLE structure (Image).
        La table cible doit s'appeler 'tracabilite' (ou le nom défini par le groupe Contrôle).
        """
        if not self.conn: return
        
        # Liste des colonnes exactes de l'image
        columns = [
            "ID_Demande", "Statut_Demande", "Raison_Refus", "Type_Mouvement",
            "Loc_Dep", "Loc_Arrive", 
            "Nb_MP", "Nb_MPf", "Nb_PF", "Nb_PFf", 
            "Nb_EPAL", "Nb_EPALh", "Nb_ISO", "Quantité_Palette",
            "Ref_Camion", "Type_Camion", "Carburant_Camion", "Capacité_Max_Palette",
            "Date_Demande", "Heure_Demande", "Temps_Acceptation",
            "Heure_Départ", "Heure_Arrivée", "Temps_Transport_Total",
            "Distance_Transport", "Coût_Transport", "Consommation_Estimée", "Taux_Remplissage"
        ]
        
        placeholders = ", ".join(["%s"] * len(columns))
        col_names = ", ".join(columns)
        
        values = [data.get(c) for c in columns]

        try:
            with self.conn.cursor() as cur:
                sql = f"INSERT INTO tracabilite ({col_names}) VALUES ({placeholders})"
                cur.execute(sql, values)
                print(f"💾 [BDD] Log inséré pour demande {data['ID_Demande']}")
        except Exception as e:
            print(f"❌ Erreur SQL Insert : {e}")