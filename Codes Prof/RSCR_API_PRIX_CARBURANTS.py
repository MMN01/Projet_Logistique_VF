##----*
#Ce programme utilise une Web API du gouvernement Français pour récupérer le prix du carburant en temps réel
#
#Lancez ce programme depuis un terminal via : python3 RSCR_API_PRIX_CARBURANTS.py
#   input : le lien de l'API (et ses arguments [=filtres])
#   output : les informations récupérées depuis l'API et sérialisées dans un JSON
#
#Plus d'informations sur l'API et son utilisation via le site suivant :
#   https://data.economie.gouv.fr/explore/dataset/prix-des-carburants-en-france-flux-instantane-v2/api/?refine.carburants_disponibles=Gazole 
#
#Information complémentaires sur la standardisation des données entre cette API et la Table "TRUCKS_CONSUMPTION" :
#   Il serait pertinent d'appeler cette API toutes les 24min [réelles], soit 1j [projet]
#   Concenrnant les termes utilisés en BDD et via cette API ; ci-dessous, une correspondance BDD <=> API :
#       DIESEL <=> gazole
#       GASOLINE <=> sp98 ou sp95
#       LPG <=> GPLc
#   Il est important de noter que cette API ne remonte ni les tarifs de l'électricité, ni ceux de l'hydrogène
#
##----*


from urllib.request import urlopen
import json

#Le lien pointe vers une station Parisienne (cette station est le point de référence pour le prix du carburant)
link = "https://data.economie.gouv.fr/api/explore/v2.1/catalog/datasets/prix-des-carburants-en-france-flux-instantane-v2/records?where=id%3A%2291170007%22&limit=20"
#link = "https://data.economie.gouv.fr/api/explore/v2.1/catalog/datasets/prix-des-carburants-en-france-flux-instantane-v2/records?where=id%3A%2278550005%22&limit=20" #Deuxième lien (si la 1ere station service n'est pas opérationnelle)

f = urlopen(link) #Lecture de l'URL
json_object = json.loads(f.read()) #Sérialisation en JSON

json_formatted_str = json.dumps(json_object, indent=2) #Mise en forme du JSON pour un affichage dans le terminal
print(json_formatted_str) #Affichage de l'ensemble des informations du JSON

#Exemple d'accès à une information spécifique du JSON ; l'ID de la première station retournée comme résultat par l'API
print("\n\nAccès information (exemple)\n\tID : \t",json_object["results"][0]["id"])
