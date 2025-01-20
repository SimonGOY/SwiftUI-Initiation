//
//  AddItemView.swift
//  SwiftUI Initiation
//
//  Created by Simon GOY on 1/20/25.
//

import SwiftUI

enum Rarity: String, CaseIterable, Identifiable {
    case common, uncommon, rare, epic, legendary, unique

    var id: String { self.rawValue }
}

struct AddItemView: View {
    @EnvironmentObject var inventory: Inventory // Accès à l'inventaire partagé
    @Environment(\.dismiss) var dismiss // Méthode pour fermer la vue
    @State private var name = "" // Nom de l'objet à ajouter
    @State private var rarity: Rarity = .common // Rareté de l'objet

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Nom de l'objet", text: $name) // Saisie du nom
                    Picker("Rareté", selection: $rarity) {
                        ForEach(Rarity.allCases, id: \.self) { rarity in
                            Text(rarity.rawValue.capitalized)
                        }
                    }
                }

                Button(action: {
                    if !name.isEmpty {
                        inventory.addItem(item: name) // Ajout de l'item à l'inventaire
                        dismiss() // Fermeture de la vue
                    }
                }) {
                    Text("Ajouter")
                }
            }
            .navigationTitle("Ajouter un objet")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Ajouter") {
                        if !name.isEmpty {
                            inventory.addItem(item: name) // Ajout de l'item et fermeture de la vue
                            dismiss() // Ferme la vue après l'ajout
                        }
                    }
                }
            }
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
            .environmentObject(Inventory())
    }
}
