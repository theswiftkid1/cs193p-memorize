//
//  GameViewModel.swift
//  Memorize
//
//  Created by theswiftkid_ on 7/7/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI
import Foundation

struct EmojiGameViewModel {
    private(set) var model: GameModel<String> = EmojiGameViewModel.createGameModel()
    
    static func createGameModel() -> GameModel<String> {
        var emojis = ["😇","😎","😘","😁","🧐", "🥳", "🤩", "🙁", "😤", "🤪", "🤓", "🙃"]
        let numberOfPairs = Int.random(in: 2...5)
        return GameModel<String>(numberOfPairsOfCards: numberOfPairs) { index in
            return emojis.remove(at: index)
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
}
