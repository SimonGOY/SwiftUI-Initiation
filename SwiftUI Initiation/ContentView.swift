//
//  ContentView.swift
//  SwiftUI Initiation
//
//  Created by Simon GOY on 1/20/25.
//

import SwiftUI

class Inventory: ObservableObject {
    @Published var loot = ["Epée", "Bouclier", "Armure"]
    
    func addItem(item: String) {
        loot.append(item)
    }
}

struct ContentView: View {
    @StateObject var inventory = Inventory()
        
    @State var showAddItemView = false

    var body: some View {
        NavigationStack {
            List {
                Button(action: {
                    inventory.addItem(item: "Magie de feu")
                }, label: {
                    Text("Ajouter")
                })
                ForEach(inventory.loot, id: \.self) { item in
                    Text(item)
                }
            }
            .navigationTitle("Loot")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) { // Bouton en haut à droite
                    Button(action: {
                        showAddItemView.toggle() // Basculer l'affichage de la vue
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showAddItemView) { // Affichage modale
                AddItemView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    
