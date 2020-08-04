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
    @State private var gameTime = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let cardAspectRatio: CGFloat = 2/3
    
    private var buttonOverlay: some View {
        let rectangle = RoundedRectangle(cornerRadius: 20.0)
        
        switch gameModel.model.theme.color {
        case let .Solid(color):
            return AnyView(
                rectangle
                    .stroke(color, lineWidth: 5)
                    .foregroundColor(color)
            )
        case let .Gradient(gradient):
            return AnyView(rectangle.stroke(gradient, lineWidth: 5))
        }
    }
    
    var body: some View {
        VStack {
            Text(gameModel.model.theme.name + "!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            Text("Points: \(gameModel.model.points)")

            Text("Time: \(gameTime) seconds")
                .onReceive(timer) { _ in
                    self.gameTime += 1
            }
            
            Grid(items: gameModel.cards) { card in
                CardView(card: card, theme: self.gameModel.model.theme).onTapGesture {
                    self.gameModel.choose(card: card)
                }
                .aspectRatio(self.cardAspectRatio, contentMode: .fit)
                .padding()
            }
            .padding()
            
            Button(action: {
                self.gameModel.newGame()
                self.gameTime = 0
            }) {
                Text("New Game")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .padding()
                    .overlay(buttonOverlay)
            }
        }
    }
}

struct CardView: View {
    var card: GameModel<String>.Card
    
    var theme: Theme
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 5
    private let fontScaleFactor: CGFloat = 0.7
    
    private var CardBorder: some View {
        let rectangle = RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(lineWidth: edgeLineWidth)
        
        switch theme.color {
        case let .Solid(color):
            return AnyView(rectangle.fill(color))
        case let .Gradient(gradient):
            return AnyView(rectangle.fill(gradient))
        }
    }
    
    private var CardBack: some View {
        let rectangle = RoundedRectangle(cornerRadius: cornerRadius)
        
        switch theme.color {
        case let .Solid(color):
            return AnyView(rectangle.fill(color))
        case let .Gradient(gradient):
            return AnyView(rectangle.fill(gradient))
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }

    private func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                CardBorder
                Pie(
                    startAngle: Angle.degrees(-90),
                    endAngle: Angle.degrees(-20)
                ).padding(5).foregroundColor(.orange).opacity(0.3)
                Text(card.content)
            } else if !card.isMatched {
                CardBack
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiGameViewModel()
        game.choose(card: game.cards[2])
        return GameView(gameModel: game)
    }
}
