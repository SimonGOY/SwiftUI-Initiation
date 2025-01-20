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

    @State private var errorMessage: String = "" // Message d'erreur pour la validation

    var body: some View {
        NavigationStack {
            Form {
                // Première section : Nom et Rareté
                Section {
                    TextField("Nom de l'objet", text: $name)
                        .onChange(of: name, perform: { _ in validateForm() }) // Validation en temps réel

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
                                .tag(game)
                        }
                    }
                    .onChange(of: selectedGame, perform: { _ in validateForm() })

                    Stepper("Quantité: \(quantity)", value: $quantity, in: 0...100)
                }

                // Troisième section : Type
                Section {
                    Text("Type : \(selectedType.rawValue)")
                        .font(.title2)

                    Picker("Choisissez un type", selection: $selectedType) {
                        ForEach(ItemType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                                .font(.title)
                                .tag(type)
                        }
                    }
                    .pickerStyle(PalettePickerStyle())
                    .onChange(of: selectedType, perform: { _ in validateForm() })
                }

                // Quatrième section : Stat d'attaque
                Section {
                    Toggle("Item d'attaque ?", isOn: $hasAttackStrength)

                    if hasAttackStrength {
                        Stepper("Stat d'attaque: \(attackStrength)", value: $attackStrength, in: 0...100)
                    }
                }

                // Message d'erreur
                if !errorMessage.isEmpty {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }

                // Bouton pour ajouter l'item
                Section {
                    Button(action: {
                        let newItem = LootItem(
                            quantity: quantity,
                            name: name,
                            type: selectedType,
                            rarity: rarity,
                            attackStrength: hasAttackStrength ? attackStrength : nil,
                            game: selectedGame
                        )
                        inventory.addItem(item: newItem)
                        dismiss()
                    }) {
                        Text("Ajouter")
                    }
                    .disabled(!isFormValid) // Désactive si le formulaire est invalide
                }
            }
            .navigationTitle("Ajouter un objet")
            .onAppear(perform: validateForm) // Valide le formulaire au chargement
        }
    }

    // Fonction de validation
    private func validateForm() {
        if name.isEmpty {
            errorMessage = "Le nom de l'objet ne doit pas être vide."
        } else if name.count < 3 {
            errorMessage = "Le nom de l'objet doit contenir au moins 3 caractères."
        } else if selectedType == .unknown {
            errorMessage = "Le type d'objet ne peut pas être 'unknown'."
        } else if selectedGame == .emptyGame {
            errorMessage = "Le jeu ne peut pas être 'emptyGame'."
        } else {
            errorMessage = "" // Pas d'erreurs
        }
    }

    // Indique si le formulaire est valide
    private var isFormValid: Bool {
        errorMessage.isEmpty
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
            .environmentObject(Inventory())
    }
}
