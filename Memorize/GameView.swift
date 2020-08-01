//
//  ContentView.swift
//  Memorize
//
//  Created by theswiftkid_ on 7/7/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var gameModel: EmojiGameViewModel
    
    var body: some View {
        VStack {
            Text(gameModel.model.theme.name + "!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            Text("Points: \(gameModel.model.points)")
            
            Grid(items: gameModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.gameModel.choose(card: card)
                }
                .aspectRatio(2/3, contentMode: .fit)
                .padding()
            }
            .padding()
            .foregroundColor(gameModel.model.theme.color)

            Button(action: {
                self.gameModel.newGame()
            }) {
                Text("New Game")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20.0)
                            .stroke(gameModel.model.theme.color, lineWidth: 5)
                            .foregroundColor(gameModel.model.theme.color)
                )
            }
        }
    }
}

struct CardView: View {
    var card: GameModel<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else if !card.isMatched {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    let cornerRadius: CGFloat = 10
    let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.75
    let cardAspectRatio: CGFloat = 2/3
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiGameViewModel()
        game.choose(card: game.cards[2])
        return GameView(gameModel: game)
    }
}
