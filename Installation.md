# Projection Mapping Setup

Compter 1h30 par projecteur + 30 min. de marge. S'il y a 2 projecteurs, compter donc 1 service de 3h30.

## Suspendre les projecteurs

* Fixer les projecteurs sur des platines avec une spanset, ajouter une griffe
* Suspendre les projecteurs au grill technique, les cabler
* Noter que ce n'est pas un problème à ce stade si les images projetées ne sont pas alignée, ou si les projecteurs ne sont pas complètement à l'horizontale (on le corrigera dans MadMapper)

## Préparation de l'alignement

* Créer une mire de test (grille de carrés noir/blanc, avec une frange orange de 1px sur la taille exacte de chaque projecteur)
* Importer cette mire de test en tant que Media dans MadMapper
* Configurer la largeur et hauteur de la scène (Master Settings > Stage size) pour qu'elle couvre tous les projecteurs mis côte à côte (par exemple, 2560x1024 s'il y a 2 projecteurs 1280x1024)
* Ajouter les projecteurs côte à côte, dans leur résolution native
Créer une surface et faire un mapping 1:1

(https://github.com/olange/diaporama/blob/master/data/mire.png)
(image ordi avec MadMapper + projection à l'arrière plan)

## Ajuster la position et couleur des projecteurs

* Ajuster la position des projecteurs
* Sur chaque projecteur, régler son orientation (de sorte qu'on puisse aisément lire le menu, qu'il ne soit pas inversé)
* Ajuster le trapèze de chaque projecteur
* Ajuster ensuite la luminosité, le contraste, la température des couleurs, le gamma pour que les projecteurs soient tous à peu près dans le même espace de couleurs

(image panoramique avec mire non alignée)

## Ajuster les zones de projections (emplacement et rotation)

* Dans MadMapper, dans la partie Output, ajuster la position des zones de projection, de sorte que les images projetées soient bien alignées, c'est-à-dire que la mire soit continue
* Ajuster également la rotation de ces zones de projection; les vis des platines et des griffes placent inévitablement les projecteurs légèrement de travers

(image ordi avec MadMapper + zones projection ajustées)
(image scène avec Léon et Louis devant le quadrillage)