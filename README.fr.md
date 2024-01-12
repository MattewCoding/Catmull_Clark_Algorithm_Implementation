# Catmull Clark Algorithm Implementation
[![en](https://img.shields.io/badge/lang-en-red.svg)](https://github.com/MattewCoding/Catmull_Clark_Algorithm_Implementation/blob/main/README.md)

Une implémentation de l'algorithme Catmull-Clark dans Processing (Java).

## Démarrage

### Prérequis
Assurez-vous que Processing est installé sur votre machine. Vous pouvez le télécharger à partir de Processing.org.

### Installation
Clonez ou téléchargez ce dépôt sur votre machine locale.
```bash
git clone https://github.com/your-username/processing-sandbox.git
```

Ouvrez le projet dans Processing en double-cliquant sur le fichier .pde ou en naviguant vers "File > Open" dans l'IDE Processing.

## Exécuter le programme

Une fois le projet ouvert dans Processing, cliquez simplement sur le bouton "Run" (une icône de lecture) dans le coin supérieur gauche de l'IDE Processing.
Ceci compilera et exécutera le programme, lançant une fenêtre affichant la sortie visuelle.

## Aperçu du projet
Une fois que vous êtes entré dans le programme, vous serez accueilli par un cube au centre et des options à gauche et à droite.

Le panneau de gauche est utilisé pour sélectionner la forme spécifique à modifier (cube, pyramide, tore), en cliquant sur la case à cocher correspondante.
Des options supplémentaires s'ouvrent si vous choisissez la pyramide ou le tore. Pour la pyramide, vous pouvez modifier sa base. Pour le tore, vous pouvez
sélectionner le nombre de points utilisés pour approximer le cercle sur lequel dessiner le tore. Vous pouvez également sélectionner le nombre de fois où
l'algorithme de Catmull-Clark sera appliqué à la forme. **Remarque:** Le programme ralentit considérablement aux niveaux 3 et 4, car le code n'est pas
optimisé. Préparez-vous à ce que le programme se bloque pendant un certain temps lors de l'exécution de l'algorithme.

Le panneau de droite est utilisé pour modifier l'orientation de la forme, dans le plan x ou y, ainsi que pour ajuster la distance par rapport à la caméra
(c'est-à-dire la rendre plus grande ou plus petite).

## Licence
Ce projet est sous licence GPL 3.0 - voir `LICENSE.txt` pour plus de détails.
