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
        HStack {
            ForEach(gameModel.cards) { card in
                CardView(card: card)
                    .onTapGesture {
                        self.gameModel.choose(card: card)
                }
            }
        }
        .padding()
        .foregroundColor(Color.orange)
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
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
        .aspectRatio(cardAspectRatio, contentMode: .fit)
        .font(Font.system(size: fontSize(for: size)))
    }
    
    let cornerRadius: CGFloat = 10
    let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.75
    let cardAspectRatio: CGFloat = 0.75

    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiGameViewModel()
        return GameView(gameModel: game)
    }
}
