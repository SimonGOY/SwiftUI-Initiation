//
//  LootDetailView.swift
//  SwiftUI Initiation
//
//  Created by Simon GOY on 1/20/25.
//
    
import SwiftUI

struct LootDetailView: View {
    var item: LootItem
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                // Icon et titre
                VStack(spacing: 16) {
                    // Icône avec ombre
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(item.rarity.color)
                            .frame(width: 160, height: 160)
                            .shadow(color: item.rarity.color.opacity(0.7), radius: 40, x: 0, y: 0)
                        
                        Text(item.type.rawValue)
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                    }
                    
                    // Nom de l'item
                    Text(item.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(item.rarity.color)
                }
                .padding(.vertical, 40)
                
                // Bannière "Item Unique" pour les objets uniques
                if item.rarity == .unique {
                    HStack {
                        Text("Item Unique")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        Text("🏆")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(item.rarity.color)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                
                // Section Informations
                VStack(alignment: .leading, spacing: 0) {
                    Text("INFORMATIONS")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 8)
                    
                    VStack(spacing: 0) {
                        // Jeu avec placeholder
                        HStack {
                            if let coverName = item.game.coverName, !coverName.isEmpty,
                               let coverURL = URL(string: coverName) {
                                AsyncImage(url: coverURL) { phase in
                                    switch phase {
                                    case .empty, .failure:
                                        placeholderView
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 58)
                                            .clipShape(RoundedRectangle(cornerRadius: 4))
                                    @unknown default:
                                        placeholderView
                                    }
                                }
                            } else {
                                placeholderView
                            }
                            Text(item.game.name)
                            Spacer()
                        }
                        .padding(16)
                        .background(Color.white)
                        
                        Divider()
                        
                        // In-game
                        HStack {
                            Text("In-game :")
                            Text(item.name)
                            Spacer()
                        }
                        .padding(16)
                        .background(Color.white)
                        
                        Divider()
                        
                        // Puissance
                        if let attackStrength = item.attackStrength {
                            HStack {
                                Text("Puissance (ATQ) :")
                                Text("\(attackStrength)")
                                Spacer()
                            }
                            .padding(16)
                            .background(Color.white)
                            
                            Divider()
                        }
                        
                        // Possédé(s)
                        HStack {
                            Text("Possédé(s) :")
                            Text("\(item.quantity)")
                            Spacer()
                        }
                        .padding(16)
                        .background(Color.white)
                        
                        Divider()
                        
                        // Rareté
                        HStack {
                            Text("Rareté :")
                            Text(item.rarity.rawValue.capitalized)
                                .foregroundColor(item.rarity.color)
                            Spacer()
                        }
                        .padding(16)
                        .background(Color.white)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Loot")
            }
            .foregroundColor(.blue)
        })
    }
    
    // Placeholder View
    private var placeholderView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [Color.gray.opacity(0.4), Color.gray.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 58, height: 58)
            
            Image(systemName: "rectangle.slash")
                .font(.title2)
                .foregroundColor(.black.opacity(0.4))
                .padding(16)
        }
    }
}

struct LootDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LootDetailView(item: LootItem(
            quantity: 2,
            name: "Épée Légendaire",
            type: .poison,
            rarity: .legendary,
            attackStrength: 0,
            game: Game(name: "Elden Ring", genre: .rpg, coverName: "https://images.igdb.com/igdb/image/upload/t_cover_big/co4jni.webp") // Exemple avec une URL d'image
        ))
    }
}
