# config.py
# --- BDD ---
DB_CONFIG = {
    "host": "192.168.40.117",
    "port": "5432",
    "database": "logistics",
    "user": "student",
    "password": "password"
}

# --- RESEAU ---
UDP_PORT = 40040

# --- METIER WEST-EU ---
VILLES_OUEST = ["Brest", "Düsseldorf", "Dusseldorf", "Lyon"]

# Vitesses moyennes (pour le calcul Temps_Transport_Total)
VITESSE_COURTE = 66.5 # km/h (< 500km ou 5h)
VITESSE_LONGUE = 74.9 # km/h (> 500km)

# Prix carburants (Estimations pour Coût_Transport)
PRIX_CARBURANTS = {
    "Diesel": 1.70, "Essence": 1.80, "GPL": 0.90, "Electrique": 0.25, "Hydrogène": 12.0
}
COUT_CHAUFFEUR_HORAIRE = 25.0 # Estimation coût main d'oeuvre