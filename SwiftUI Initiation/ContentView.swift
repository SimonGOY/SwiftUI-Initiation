//
//  ContentView.swift
//  SwiftUI Initiation
//
//  Created by Simon GOY on 1/20/25.
//

import SwiftUI

class Inventory: ObservableObject {
    @Published var loot: [LootItem] = []  // L'inventaire contenant des LootItem
    
    func addItem(item: LootItem) {
        loot.append(item)
    }
}

struct ContentView: View {
    @StateObject var inventory = Inventory()
    @State private var showAddItemView = false

    var body: some View {
        NavigationStack {
            List {
                
                ForEach(inventory.loot, id: \.id) { item in
                    NavigationLink {
                        LootDetailView(item: item) // Passer l'item à la vue de détail
                    } label: {
                        ExtractedView(item: item)
                    }
                }
            }
            .navigationTitle("Inventaire")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddItemView.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showAddItemView) {
                AddItemView()
                    .environmentObject(inventory)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
