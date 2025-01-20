//
//  LootRow.swift
//  SwiftUI Initiation
//
//  Created by Simon GOY on 1/20/25.
//

import SwiftUI

struct ExtractedView: View {
    var item: LootItem
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                // Rareté en point de couleur
                HStack {
                    Circle()
                        .fill(item.rarity.color)
                        .frame(width: 10, height: 10)
                    Text(item.name)
                        .fontWeight(.bold)
                }
                
                // Quantité sous le nom de l'objet
                Text("Quantité: \(item.quantity)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            // Emoji du type de l'item en haut à droite
            Text(item.type.rawValue)
                .font(.title)
                .frame(width: 30, height: 30)
        }
        .padding()
    }
}
