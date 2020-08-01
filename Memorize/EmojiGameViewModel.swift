//
//  GameViewModel.swift
//  Memorize
//
//  Created by theswiftkid_ on 7/7/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

class EmojiGameViewModel: ObservableObject {
    @Published private(set) var model: GameModel<String> = EmojiGameViewModel.createGameModel()
    
    static func createGameModel() -> GameModel<String> {
        let theme = themes.randomElement()!
        let numberOfPairs = Int.random(in: 2...theme.emojis.count)
        let themedEmojis = theme.emojis
        return GameModel<String>(theme: theme, numberOfPairsOfCards: numberOfPairs) { index in
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
        model = EmojiGameViewModel.createGameModel()
    }
}
