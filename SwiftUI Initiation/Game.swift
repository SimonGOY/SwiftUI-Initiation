//
//  Game.swift
//  SwiftUI Initiation
//
//  Created by Simon GOY on 1/20/25.
//

import SwiftUI

enum GameGenre {
    case mmorpg, rpg, looter, fps, tps, strategy, unset
}

struct Game: Identifiable, Hashable {
    let name: String
    let id: UUID = UUID()
    let genre: GameGenre
    let coverName : String?
    
    static var emptyGame = Game(name: "", genre: .unset, coverName: nil)
}

// Hesitez pas mettre vos propres jeux dans la liste
let availableGames = [
    Game(name: "Elden Ring", genre: .rpg, coverName: "https://images.igdb.com/igdb/image/upload/t_cover_big/co4jni.webp"),
    Game(name: "Skyrim", genre: .rpg, coverName: "https://images.igdb.com/igdb/image/upload/t_cover_big/co1tnw.webp"),
    Game(name: "WoW", genre: .mmorpg, coverName: "https://images.igdb.com/igdb/image/upload/t_cover_big/co2l7z.webp"),
    Game(name: "CS:GO", genre: .fps, coverName: "https://images.igdb.com/igdb/image/upload/t_cover_big/co6996.webp"),
    Game(name: "Diablo IV", genre: .looter, coverName: "https://images.igdb.com/igdb/image/upload/t_cover_big/co69sm.webp")
]
