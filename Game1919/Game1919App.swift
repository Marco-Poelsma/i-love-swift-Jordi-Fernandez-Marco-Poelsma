//
//  Game1919App.swift
//  Game1919
//
//  Created by alumne on 10/11/2025.
//

import SwiftUI

@main
struct GameApp: App {
    @StateObject var gameStore = GameStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameStore)
        }
    }
}
