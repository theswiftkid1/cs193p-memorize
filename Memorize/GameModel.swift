//
//  Game.swift
//  Memorize
//
//  Created by theswiftkid_ on 7/7/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

struct GameModel<CardContent> {
    var cards: Array<Card>
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
    }
        
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for index in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(index)
            cards.append(Card(id: index * 2, content: content))
            cards.append(Card(id: index * 2 + 1, content: content))
        }
        cards.shuffle()
    }
    
    func indexOf(of card: Card) -> Int {
        for index in 0..<cards.count {
            if (cards[index].id == card.id) {
                return index
            }
        }
        return 0
    }
    
    mutating func choose(card: Card) {
        print("Chosen card \(card)")
        let cardIndex = indexOf(of: card)
        cards[cardIndex].isFaceUp = !cards[cardIndex].isFaceUp
    }
}
