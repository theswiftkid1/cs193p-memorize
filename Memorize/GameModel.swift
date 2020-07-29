//
//  Game.swift
//  Memorize
//
//  Created by theswiftkid_ on 7/7/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

struct GameModel<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    
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
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for index in stride(from: numberOfPairsOfCards, to: 0, by: -1) {
            let content = cardContentFactory(index)
            cards.append(Card(id: index * 2, content: content))
            cards.append(Card(id: index * 2 + 1, content: content))
        }
        cards.shuffle()
    }
    
    mutating func choose(card: Card) {
        if let cardIndex = cards.firstIndex(of: card),
            !cards[cardIndex].isFaceUp,
            !cards[cardIndex].isMatched {
            
            if let potentialMatch = currentFaceUpCardIndex {
                if cards[potentialMatch].content == cards[cardIndex].content {
                    cards[potentialMatch].isMatched = true
                    cards[cardIndex].isMatched = true
                }
                cards[cardIndex].isFaceUp = true
            } else {
                currentFaceUpCardIndex = cardIndex
            }
        }
    }
}
