//
//  AddItemView.swift
//  SwiftUI Initiation
//
//  Created by Simon GOY on 1/20/25.
//

import SwiftUI

struct AddItemView: View {
    @EnvironmentObject var inventory: Inventory
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var rarity: Rarity = .common
    @State private var selectedGame: Game = availableGames[0]
    @State private var quantity: Int = 1
    @State private var selectedType: ItemType = .magic
    @State private var hasAttackStrength: Bool = false
    @State private var attackStrength: Int = 0 

    var body: some View {
        NavigationStack {
            Form {
                // Première section : Nom et Rareté
                Section {
                    TextField("Nom de l'objet", text: $name)  // Saisie du nom
                    Picker("Rareté", selection: $rarity) {
                        ForEach(Rarity.allCases, id: \.self) { rarity in
                            Text(rarity.rawValue.capitalized)
                        }
                    }
                }

                // Deuxième section : Jeu et Quantité
                Section {
                    Picker("Jeu", selection: $selectedGame) {
                        ForEach(availableGames, id: \.id) { game in
                            Text(game.name)
                                .tag(game)  // Utilisation du jeu complet comme tag
                        }
                    }
                }

                Section {
                    Text("Type : \(selectedType.rawValue)")  // Affiche le type sélectionné et l'emoji associé
                        .font(.title2)

                    Picker("Choisissez un type", selection: $selectedType) {
                        // Crée une option pour chaque type
                        ForEach(ItemType.allCases, id: \.self) { type in
                            Text(type.rawValue) // Utilisation de l'emoji comme texte pour chaque option
                                .font(.title)
                                .tag(type) // Définit l'élément sélectionné pour chaque case
                        }
                    }
                    .pickerStyle(PalettePickerStyle())  // Utilisation d'un style de picker pour afficher les options de manière plus évidente
                }


                // Quatrième section : Stat d'attaque
                Section {
                    Toggle("Item d'attaque ?", isOn: $hasAttackStrength)  // Toggle pour activer/désactiver la stat d'attaque

                    if hasAttackStrength {
                        Stepper("Stat d'attaque: \(attackStrength)", value: $attackStrength, in: 0...100)
                    }
                }

                // Bouton pour ajouter l'item
                Button(action: {
                    if !name.isEmpty {
                        let newItem = LootItem(
                            quantity: quantity,
                            name: name,
                            type: selectedType,  // Utilisation du type sélectionné
                            rarity: rarity,
                            attackStrength: hasAttackStrength ? attackStrength : nil,  // Stat d'attaque seulement si activée
                            game: selectedGame  // Jeu sélectionné
                        )
                        inventory.addItem(item: newItem)  // Ajout de l'item à l'inventaire
                        dismiss()  // Fermeture de la vue modale
                    }
                }) {
                    Text("Ajouter")
                }
            }
            .navigationTitle("Ajouter un objet")
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
            .environmentObject(Inventory())  // Nécessaire pour les previews
    }
}
