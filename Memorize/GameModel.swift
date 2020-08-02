//
//  Game.swift
//  Memorize
//
//  Created by theswiftkid_ on 7/7/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import Foundation

struct GameModel<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    var theme: Theme
    var points: Int
    var selectionTime: Date
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
    
    var currentFaceUpCardIndex: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    init(theme: Theme,
         numberOfPairsOfCards: Int,
         cardContentFactory: (Int) -> CardContent) {
        self.theme = theme
        points = 0
        cards = Array<Card>()
        selectionTime = Date.init()
        let maxThemePairsOfCards = numberOfPairsOfCards >= theme.emojis.count ? theme.emojis.count - 1 : numberOfPairsOfCards
        for index in stride(from: maxThemePairsOfCards, to: 0, by: -1) {
            let content = cardContentFactory(index)
            cards.append(Card(id: index * 2, content: content))
            cards.append(Card(id: index * 2 + 1, content: content))
        }
        cards.shuffle()
    }
    
    func gameIsFinished() -> Bool {
        return cards.firstIndex(where: { card in
            card.isFaceUp == false
        }).isNil
    }
    
    mutating func choose(card: Card) {
        if let cardIndex = cards.firstIndex(of: card),
            !cards[cardIndex].isFaceUp,
            !cards[cardIndex].isMatched {
            
            if let potentialMatch = currentFaceUpCardIndex {
                let now = Date.init()
                let interval = DateInterval(start: selectionTime, end: now).duration
                
                if cards[potentialMatch].content == cards[cardIndex].content {
                    cards[potentialMatch].isMatched = true
                    cards[cardIndex].isMatched = true
                    points += max(10 - Int(interval), 1)
                    selectionTime = now
                } else {
                    points -= min(1 + Int(interval), 5)
                }
                cards[cardIndex].isFaceUp = true
            } else {
                currentFaceUpCardIndex = cardIndex
            }
        }
    }
}
