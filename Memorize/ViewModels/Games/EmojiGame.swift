//
//  GameViewModel.swift
//  Memorize
//
//  Created by theswiftkid_ on 7/7/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI
import Foundation

class EmojiGame: ObservableObject {
    @State private var theme: EmojiTheme
    @Published private(set) var model: GameModel<String>

    init(theme: EmojiTheme) {
        self.theme = theme
        model = EmojiGame.createGameModel(theme: theme)
    }

    private static func createGameModel(theme: EmojiTheme) -> GameModel<String> {
        let themedEmojis = theme.emojis
//        print("Random theme \(theme.json?.utf8 ?? "nil")")
        return GameModel<String>(theme: theme) { index in
            return themedEmojis[index]
        }
    }

    // MARK: Access to the Model
    
    var cards: Array<GameModel<String>.Card> {
        model.cards
    }
    
    // MARK: Intents
    
    func choose(card: GameModel<String>.Card) {
        model.choose(card: card)
    }
    
    func newGame() {
        model = EmojiGame.createGameModel(theme: theme)
    }
}
