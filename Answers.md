#  Réponses Initiation SwiftUI

## 2 - App Basic

### Exercice 1

Il manque un identifiant pour pouvoir utiliser la fonction List. (les string ne sont pas Identifiable)

### Exercice 2

- Le premier élément de la liste est maintenant un bouton suivi des "loot", un ForEach est également utilisé maintenant

- Le ForEach permet de gérer les éléments de loot et intègre le ``` id: \.self``` pour pouvoir itérer sur le tableau. Il permet également de bien marquer la différence entre le bouton et les éléments

- On sépare bien le bouton du ForEach pour pas qu'il ne soit recréé pour chaque élément et pour pouvoir le placer à l'endroit voulu dans la liste
