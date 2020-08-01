//
//  Game.swift
//  Memorize
//
//  Created by theswiftkid_ on 7/7/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

struct GameModel<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    var theme: Theme
    var points: Int
    
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
