import socket
import time
import json
import random
import string
from datetime import datetime, timedelta

# --- CONFIGURATION ---
# Pour tester en local (sur la même machine), utilisez '127.0.0.1' ou '<broadcast>'
# Si vous êtes sur un réseau local avec vos coéquipiers, utilisez l'adresse de broadcast (ex: 192.168.1.255)
# Dans le PDF, le vrai serveur est sur 192.168.40.100, mais ici on simule.
UDP_IP = '<broadcast>' 
UDP_PORT = 40040

# --- DONNÉES DU PROJET (Basées sur le PDF) ---
USINES = ["Brest", "Düsseldorf", "Lyon", "Munich", "Florence", "Bucarest"]
PORTS = ["Le Havre", "Rotterdam", "Amsterdam", "Anvers", "Marseille", "Valence", "Athènes"]
GMS = ["Manchester", "Paris", "Vienne", "Zagreb", "Séville"]

TYPES_PAL = ["EPAL", "ISO", "EPALh"]
SPECS = ["", "", "", "PTAC=12t", "COL=Green", "ENR Electric", "COL=Red", "PTAC=19t"]

def generer_id_unique():
    """Génère un ID aléatoire type '25G18U13UFLO2PMAR39E'"""
    chars = string.ascii_uppercase + string.digits
    return ''.join(random.choice(chars) for _ in range(20))

def generer_heure_depart():
    """
    Génère une heure de départ (DVL). 
    Selon le PDF: 3 à 6 min réelles plus tard.
    """
    minutes_plus_tard = random.randint(3, 6)
    future_time = datetime.now() + timedelta(minutes=minutes_plus_tard)
    return future_time.strftime("%d/%m/%y %H:%M:%S")

def creer_demande():
    """Crée une demande de transport unique respectant la logique Import/Export"""
    type_mvt = random.choice(["Import", "Export"])
    
    if type_mvt == "Import":
        # Import : Port vers Usine (Matière Première) [cite: 300]
        loc_dep = random.choice(PORTS)
        type_dep = "PORT"
        loc_arr = random.choice(USINES)
        type_arr = "USINE"
        type_mat = random.choice(["MP", "MP_frais"])
        
    else: # Export
        # Export : Usine vers GMS ou Port (Produit Fini) [cite: 301]
        loc_dep = random.choice(USINES)
        type_dep = "USINE"
        dest_type_choix = random.choice(["GMS", "PORT"])
        if dest_type_choix == "GMS":
            loc_arr = random.choice(GMS)
            type_arr = "GMS"
        else:
            loc_arr = random.choice(PORTS)
            type_arr = "PORT"
        type_mat = random.choice(["PF", "PF_frais"])

    # Structure JSON exacte demandée 
    demande = {
        "TYPE_MVT": type_mvt,
        "LOC_DEP": loc_dep,
        "LOC_ARR": loc_arr,
        "TYPE_DEP": type_dep,
        "TYPE_ARR": type_arr,
        "TYPE_MAT": type_mat,
        "QTE_PAL": random.randint(1, 33), # Max palette standard
        "TYPE_PAL": random.choice(TYPES_PAL),
        "H_DEP": generer_heure_depart(),
        "SPEC": random.choice(SPECS)
    }
    
    return {generer_id_unique(): demande}

def main():
    # Création du socket UDP
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    
    # Autoriser le broadcast (indispensable pour simuler le comportement du prof) [cite: 390]
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)

    print(f"--- Faux Serveur ERP Démarré ---")
    print(f"Diffusion sur {UDP_PORT} (Broadcast)")
    print("Appuyez sur Ctrl+C pour arrêter.")

    try:
        while True:
            # Le PDF dit que les demandes arrivent toutes les 3 à 5 secondes 
            wait_time = random.uniform(3, 5)
            time.sleep(wait_time)

            # Parfois plusieurs demandes en même temps [cite: 383]
            nb_demandes = random.choices([1, 2, 3], weights=[70, 20, 10])[0]
            
            message_dict = {}
            for _ in range(nb_demandes):
                message_dict.update(creer_demande())

            # Conversion en JSON et encodage en bytes
            message_json = json.dumps(message_dict)
            message_bytes = message_json.encode('utf-8')

            # Envoi du message
            # Si <broadcast> ne marche pas sur Windows, essayez l'IP locale ou 127.0.0.1
            try:
                sock.sendto(message_bytes, (UDP_IP, UDP_PORT))
                print(f"[Envoyé] {message_json}")
            except PermissionError:
                print("Erreur: Permission refusée pour le Broadcast. Essayez de lancer en Admin ou changez l'IP cible.")
                break
            except Exception as e:
                print(f"Erreur d'envoi : {e}")

    except KeyboardInterrupt:
        print("\nArrêt du serveur.")
        sock.close()

if __name__ == "__main__":
    main()