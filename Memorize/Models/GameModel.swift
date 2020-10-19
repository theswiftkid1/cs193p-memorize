//
//  Game.swift
//  Memorize
//
//  Created by theswiftkid_ on 7/7/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import Foundation

struct GameModel<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var theme: Theme
    private(set) var points: Int
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
            
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        
        // MARK: - Bonus Time
        
        var bonusTimeLimit: TimeInterval = 6
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }

        var bonusTimeRemaining: Double {
            max(0, bonusTimeLimit - faceUpTime)
        }

        var bonusTimeRemainingPercentage: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }

        var bonusPointsRemaining: Int {
            Int(bonusTimeRemaining)
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
    }

    private var currentFaceUpCardIndex: Int? {
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
         cardContentFactory: (Int) -> CardContent) {
        self.theme = theme
        points = 0
        cards = Array<Card>()
        let maxThemePairsOfCards = theme.numberOfPairs >= theme.emojis.count ? theme.emojis.count - 1 : theme.numberOfPairs
        for index in stride(from: maxThemePairsOfCards, to: 0, by: -1) {
            let content = cardContentFactory(index)
            cards.append(Card(id: index * 2, content: content))
            cards.append(Card(id: index * 2 + 1, content: content))
        }
        cards.shuffle()
    }

    // MARK: - Choose

    mutating func choose(card: Card) {
        if let cardIndex = cards.firstIndex(of: card),
            !cards[cardIndex].isFaceUp,
            !cards[cardIndex].isMatched {
            
            if let potentialMatch = currentFaceUpCardIndex {
                if cards[potentialMatch].content == cards[cardIndex].content {
                    cards[potentialMatch].isMatched = true
                    cards[cardIndex].isMatched = true
                    points += 1 + cards[cardIndex].bonusPointsRemaining
                } else {
                    points -= 1
                }
                cards[cardIndex].isFaceUp = true
            } else {
                currentFaceUpCardIndex = cardIndex
            }
        }
    }
}
