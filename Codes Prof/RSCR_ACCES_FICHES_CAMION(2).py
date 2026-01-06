##----*
#Ce programme montre :
#       Comment accéder aux "Fiches Camion" situées dans un répertoire du serveur de virtualisation PROXMOX de l'ENSIBS ;
#       Comment ouvrir et accéder aux données des fiches (seuls les fichiers .csv et .json sont traités)
#
#Cette fonction est surtout un test simple qui montre comment traiter la lecture de fichiers (csv et json)
#Pour ce tutoriel : Seules les fiches camions dont le nom de fichier contient "__exemple__" sont traitées.
#       Exemple de nom de fichier traité : "__exemple__FD-153-DS.csv"
#
#Lancez ce programme depuis un terminal via : python3 RSCR_ACCES_FICHES_CAMION.py
#   input : nom du répertoire où se situe les "Fiches Camion"
#   output : données contenues dans les "Fiches Camion"
##----*

import os
import csv
import json

repertoire = "/mnt/tp4010/DuCapteurJusquauCloud/FichesCamion/" #Répertoire où se situe les "Fiches Camion"
FichesCamion = os.listdir(repertoire) #Liste contenant l'ensemble des noms des fichiers "Fiches Camions"

##Lecture et affichage des "Fiches Camion"
print("\nLecture des 'Fiches Camion' situées dans le repertoire '%s' :" %repertoire)

for fiche in FichesCamion : #Pour chaque "Fiche Camion" située dans le répertoire
    #La variable fiche est au format str
    #Exemple de format : fiche = "KL-541-GF.csv" ou "TY-160-CV.json"

    #/!\ Uniquement pour ce tutoriel : seules les "Fiches Camion" débuttant par "__exemple__" seront ouvertes et traitées
    #       >>Cela évite d'ouvrir tous les fichiers présents dans le répertoire
    if "__exemple__" not in fiche : #Si le nom du fichier ne contient pas "__exemple__"
        next #Passe à l'itération suivante de la boucle "for"


    ##Affichage des données contenues dans les "Fiches Camion"
    #Pour les fichiers type .csv
    if ".csv" in fiche :
        with open(repertoire+fiche, mode = 'r') as file :                   #Ouverture du fichier csv
            dataCSV = list(csv.reader(file, delimiter = ';'))               #Lecture et stockage de chaque ligne du fichier csv
            print("\nFichier : ",fiche,"\n>Données brutes :\n\t", dataCSV)  #Affichage de toutes les lignes

    #Pour les fichiers type .json
    elif ".json" in fiche :
        with open(repertoire+fiche, "r") as file :                          #Ouverture du fichier json
            dataJSON = json.load(file)                                      #Lecture et stockage de chaque éléments du fichier json
            print("\nFichier : ",fiche, "\n>Données brutes :\n\t", dataJSON)#Affichage de tous les éléments

    #Autres types de fichiers (que .json et .csv)
    else :
        pass #Ne rien faire