##----*
#Ce programme montre :
#       Comment récupérer les demandes de transport envoyées par l'ERP de Garden Food ;
#               - l'ERP est techniquement un ServeurUDP sur l'un des VLAN de l'ENSIBS
#               - Le ServeurUDP envoie des données (en moyenne) toutes les ~3 à 6 secondes [réelles]
#       Comment afficher et traiter (basiquement) les données des demandes de transport
#
#Cette fonction est surtout un test simple qui montre comment récupérer les données de l'ERP
#       Ce programme crée un ClientUDP qui récupère les messages envoyés depuis un ServeurUDP
#
#Lancez ce programme depuis un terminal via : python3 RSCR_ERP_CLIENT_UDP.py
#   input : chaine de connexion au serveur
#   output : données reçues par le serveur
##----*

import socket
import json
import datetime

##Informations liées au ServeurUDP & établissement de la chaine de connexion
HOST, PORT = "192.168.40.100", 40040
clientUDP = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
clientUDP.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
clientUDP.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
clientUDP.bind(("", PORT))


##Boucle principale
print("\nLancement du clientUDP. 'Ctrl+C' pour quitter le programme")
while True :
    print("\n\n\n...EN ATTENTE de la réception d'un message venant du ServeurUDP (%s:%d)..."%(HOST,PORT))
    data, addr = clientUDP.recvfrom(2048) #Réception du message envoyé par le ServeurUDP

    ##Mise en forme du message reçu
    #   Le message envoyé par le serveur est formaté en json (assimilé au format "dictionnaire" de python)
    #   Le message doit au préalable être décodé ".decode()" pour être traité comme une str
    #   Le format JSON n'accepte pas les simples quotes "'"
    json_message = json.loads(data.decode().replace("\'","\"")) #Le message est sérialisé au format JSON
    json_message4print = json.dumps(json_message, indent = 4)   #Création d'une variable servant [uniquement] à l'affichage des données reçues

    print("\n>Message reçu à",datetime.datetime.now().strftime("%H:%M:%S"))
    print(json_message4print)    #Message reçu qui a été mis en forme pour l'affichage
    print(">Exemple d'accès aux éléments du message : ", json_message.keys()) #Accès aux données via le formalisme "dictionnaire" (ici un exemple pour l'accès aux clefs)
