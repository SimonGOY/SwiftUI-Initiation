//
//  ContentView.swift
//  SwiftUI Initiation
//
//  Created by Simon GOY on 1/20/25.
//

import SwiftUI

struct ContentView: View {
    @State private var loot = ["Epée", "Bouclier", "Armure"]
    @State private var showAddItemView = false // Variable pour gérer l'affichage de AddItemView

    var body: some View {
        NavigationStack {
            List {
                ForEach(loot, id: \.self) { item in
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
    
