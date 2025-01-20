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
    @State private var name: String = "" // Nom de l'objet (vide par défaut)
    @State private var rarity: Rarity = .common // Rareté par défaut

    var body: some View {
        Form {
            Section(header: Text("Nouvel objet")) {
                TextField("Nom de l'objet", text: $name)

                Picker("Rareté", selection: $rarity) {
                    ForEach(Rarity.allCases) { rarity in
                        Text(rarity.rawValue.capitalized)
                    }
                }
            }

            Section {
                Button(action: {
                }) {
                    Text("Ajouter")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .navigationTitle("Ajouter un item")
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
