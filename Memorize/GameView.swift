//
//  ContentView.swift
//  Memorize
//
//  Created by theswiftkid_ on 7/7/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

struct GameView: View {
    var gameModel: EmojiGameViewModel
    
    var body: some View {
        let cards = HStack {
            ForEach(gameModel.cards) { card in
                CardView(card: card)
                .onTapGesture {
                    self.gameModel.choose(card: card)
                }
            }
        }
        .padding()
        .foregroundColor(Color.orange)
        
        return gameModel.cards.count >= 10 ? cards.font(.title) : cards.font(.largeTitle)
    }
}

struct CardView: View {
    var card: GameModel<String>.Card
    
    var body: some View {
        ZStack {
            if card.faceUp {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill()
            }
        }
        .aspectRatio(0.75, contentMode: .fit)
    }
}



struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiGameViewModel()
        return GameView(gameModel: game)
    }
}
