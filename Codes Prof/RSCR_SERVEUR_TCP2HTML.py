##----*
#Ce programme illustre une façon de créer une IHM Web via Python (l'IHM n'est accessible qu'en local)
#   /!\ Il est important de noter qu'une IHM Web est normalent créée en PHP (mais pour une question de simplicité pour ce projet, nous utiliserons Python)
#   Utilisez cet exemple pour générer votre propre IHM HTML
#
#Pour tester ce code :
#   Lancez ce programme via un terminal : python3 RSCR_SERVEUR_TCP2HTML.py
#   Puis lancez un navigateur web sur http://localhost:10000/
##----*

import socket
import sys
import time

##Informations liées au ServeurTCP & établissement de la chaine de connexion
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
HOST, PORT = 'localhost', 10000
    ##Note importante concernant le HOST (le PC qui héberge le "Serveur Web"):
    #   Il est possible de changer 'localhost' par "l'adresse IP du PC qui execute ce programme" afin 
    #   de rendre le "Serveur Web" accessible via une autre VM située dans le VLAN40
    #       Par exemple HOST = '192.168.40.XXX'
    #       Avec XXX : l'adresse IP de la VM qui execute ce programme
    #       Pour connaître son adresse IP, lancer un terminal et executer la commande 'ip a' (sous Linux. Sous Windows : 'ipconfig')
    #   Une autre VM pourrait alors accéder au serveur en lançant un navigateur Web sur "HOST:PORT" (dans notre exemple "192.168.40.XXX:10000")
sock.bind((HOST, PORT))
sock.listen(1)


##Programme principal
try :
    #Affichage de diverses informations concernant le serveur
    print("\nLe serveur web est démarré à l'adresse '%s' sur le port %d"%(HOST,PORT))
    print("\t'Ctrl+C' pour quitter le programme")
    print("\nLancez un navigatteur web sur 'http://%s:%d/'"%(HOST, PORT))
    print("\t...en attente d'un client...\n")
    #Attente d'un (premier) client (=Ouverture d'une page Web)
    connection, client_address = sock.accept()
    print("\tNouveau client : ", client_address) #Affichage d'informations concernant le client

    cmpt=0 #Ici, nous utiliserons un compteur comme exemple afin de montrer que la page Web se met à jour à chaque rechargement (manuel et automatique)
    
    ##Boucle principale
    while True:

        #Réception d'informations de la part du client (=Le navigateur Web)
        data = connection.recv(2028).decode('utf-8')

        cmpt+=1 #Utile seulement pour ce tutoriel. Permet d'afficher le nombre de fois que la page a été rechargée

        ##Creation du HEADER HTML
        connection.send('HTTP/1.0 200 OK\n'.encode())
        connection.send('Content-Type: text/html\n'.encode())
        connection.send('\n'.encode()) #Le HEADER et le BODY doivent être séparés d'une ligne

        ##Creation du BODY HTML. Message HTML entre triple-quote
        message = \
"""
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="refresh" content="10" /> <!-- recharge la page toutes les 10 secondes-->
        <title>TITRE ONGLET</title><!--Titre de l'onglet-->
    </head>
    <body>
        <h1>Hello World</h1>
        <i>La page se recharge automatiquement toutes les 10 secondes</i>
        <br><br>
        Vos informations : %s
        <br>
        Nombre de rechargement(s) de la page : %d
    </body>
</html>
"""%(client_address,cmpt)

        connection.send(message.encode())           #Envoi de la page html au client
        connection.close()                          #Fermeture du ServeurTCP
        time.sleep(1)                               #Attente (temps de sécurité avant une prochaine réouverture de la page)
        connection, client_address = sock.accept()  #Attente d'un nouvel accès à la page HTML
except :
    try :
        #Fermeture du serveurTCP (ServeurWeb)
        connection.close()
    except:
        #Ce cas arrive lorsqu'aucun client ne s'est connecté et que l'on quitte le programme via 'Ctrl+C'
        pass #Ne rien faire

##Fin du programme
print("\nFin du programme")