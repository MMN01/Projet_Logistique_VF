##----*
#Ce programme montre :
#       Comment accéder au serveur de base de données PostgreSQL de l'ENSIBS ;
#       Comment accéder à l'une des tables du projet (LOCATIONS_NAMES) ;
#       Comment réaliser une requête SQL (Deux exemples de requête sont présentés) ;
#       Comment traiter la réponse retournée par la requête SQL
#
#Cette fonction est surtout un test simple qui permet de savoir si les outils sont fonctionnels et si la BDD accessible
#
#Lancez ce programme depuis un terminal via : python3 RSCR_ACCES_BDD_TABLE_LOCATIONS_NAMES.py
#   input : chaine de connexion au serveur de BDD et envoi de requêtes
#   output : plusieurs exemples basiques de lecture de Table
##----*

import psycopg2

##Informations liées à la BdD
dbname = 'UE_ENS_DCJC'      #Nom du serveur de base de données Postgres
user = 'dcjc'               #Login
password = 'dcjc'           #Mot de passe
host = '192.168.40.117'     #Adresse IP du serveur de BDD
port = '5432'               #Port utilisé par l'application Postgres

table = "LOCATIONS_NAMES"   #Nom de la table

##Etablissement de la connexion au serveur de base de données
conn = psycopg2.connect(dbname = dbname, user = user, password = user, host = host, port = port)
cur = conn.cursor()


##Création de la Requête SQL
reqSQL = """ SELECT * FROM "%s" """ %(table) #1er exemple simple de requête SQL
#reqSQL = """ SELECT "PK_LOCATIONS", "NAME"  FROM "%s" WHERE "PK_LOCATIONS" BETWEEN %d AND %d ORDER BY "PK_LOCATIONS" DESC """ %(table, 4, 8) #ReqSQL à décommenter. 2e exemple
cur.execute(reqSQL)

#Affichage
print("\nConnexion à la Base de données '%s' du serveur '%s'" %(dbname, host))
print("Reqête SQL exécutée \"%s\"\n" %reqSQL)

##Affichage de la réponse à la requête SQL
results = cur.fetchall()    #Variable contenant l'ensemble de la réponse à la requête SQL.
for ligne in results:       #Pour chaque ligne de la réponse
    for colonne in ligne:   #Pour chaque colonne dans la ligne
        print("%-*s" %(15, colonne), end='') #Affichage de l'élément de la colonne (affichage formaté)
    print("")

##Fermeture de la connexion au serveur
conn.close()
print("\nFin du programme")
