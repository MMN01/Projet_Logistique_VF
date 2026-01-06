##----*
#Ce programme montre comment utiliser la bibliothèque matplotlib pour afficher des images, des graphiques...
#Les fonctions utilisées dans ce programme ne (re)présentent qu'une petite partie des possibilités de la bibliothèque
#
#Lancez ce programme depuis un terminal : python3 RSCR_MATPLOTLIB_EXEMPLES.py
#   input : /
#   output : 2 figures créées durant le programme (image "Villes" et un "BarGraphe")
#
#Plus d'exemples et d'explications de la bibliothèque matplotlib sur :
#   https://www.w3schools.com/python/matplotlib_pyplot.asp 
##----*

import matplotlib.pyplot as plt
import math

#Lecture d'une image (depuis un répertoire)
img = plt.imread("rscr/France.jpg")
plt.figure("Villes") #Création d'une fenêtre (sortie) nommée "Villes"

#Création d'une liste contenant des informations
#Villes = [Ville1, Ville2...]
#   Avec VilleX = [Nom, pos_x, pos_y, diam, color]
Villes = [
            ["Paris",500,250,80.5,'hotpink'],
            ["Marseille",700,788,53.0,'#88C999'],
            ["Lyon",666,568,22.98,'blue'],
            ["Brest",20,295,33.61,'gray']
        ]

#Ajout de cercles sur l'emplacement de chaque villes
for ville in Villes:
    _nom, _posX, _posY, _diam ,_color = ville #Accès aux information de chaque éléments de la liste "Villes"
    plt.scatter(_posX,_posY, s = _diam*10, color = _color, marker = "o", alpha = 0.5) #Ajout d'un cercle
    #A noter : ici "_diam" est multiplié par "10" afin que le cercle soit bien visible lors de l'affichage


#Exemple : ajout d'une ligne (en pointillée de couleur 'corail') entre 2 villes
#   Format : Ville = [Nom, pos_x, pos_y, diam, color]
V1 = Villes[0]
V2 = Villes[1]
plt.plot([V1[1],V2[1]], [V1[2],V2[2]],'coral',linestyle = 'dotted',linewidth = '3') #([x1,x2],[y1,y2])


#Les lignes de code ci-dessous présentent une façon de créer et d'afficher un trajet sur l'image "Villes"
#   Un trajet correspond à un ensemble de chemins qui relie plusieurs villes entre-elles
#   Lors de l'affichage : si le trajet (entre 2 villes) fait plus de 500 pixels, le chemin est affiché en rouge
Trajet = ["Brest","Paris","Lyon","Brest","Marseille"] #Création d'un trajet qui passe par plusieurs villes
for i in range(0,len(Trajet)-1): #Pour chaque paire de ville dans le tableau : V1>>V2 puis V2>>V3, V3>>V4 ...
    #Rappel : Format Ville = [Nom, x, y, diam, color]
    (x1,y1) = [(ville[1],ville[2]) for ville in Villes if ville[0] == Trajet[i]][0]
    (x2,y2) = [(ville[1],ville[2]) for ville in Villes if ville[0] == Trajet[i+1]][0]
    distance = math.sqrt((x2-x1)**2+(y2-y1)**2)
    if distance > 500 :
        _color = 'red'
    else:
        _color = 'green'
    plt.plot([x1,x2], [y1,y2],_color) #Affichage d'une ligne entre les 2 villes


#Génération de l'image nommée "Villes"
plt.imshow(img)
plt.axis('off')




#Génération d'une figure de type 'BarGraph'
#   Création de 2 listes qui récupèrent chacune un seul élement de la liste initiale "Villes"
ville = [ville[0] for ville in Villes]  #Ensemble des "noms"
diam = [ville[3] for ville in Villes]   #Ensemble des "diamètres"

plt.figure('BarGraphe1')
plt.bar(ville, diam)
plt.xlabel('Ville')
plt.ylabel('Diam')

#Affichage de toutes les images et figures créées durant le programme
#   Fonction à n'appeler qu'une seule fois ; même s'il y a plusieurs fenêtres à afficher
plt.show()