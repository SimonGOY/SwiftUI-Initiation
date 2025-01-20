//
//  ContentView.swift
//  SwiftUI Initiation
//
//  Created by Simon GOY on 1/20/25.
//

import SwiftUI

struct ContentView: View {
    var loot = ["Epée", "Bouclier", "Armure"]

    func addLoot() {
        loot.append("Magie de feu")
    }

    var body: some View {
        List {
            Button(action: {
                addLoot()
            }, label: {
                Text("Ajouter")
            })

            ForEach(loot, id: \.self) { item in
                Text(item)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
