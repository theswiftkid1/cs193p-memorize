//
//  ContentView.swift
//  Memorize
//
//  Created by theswiftkid_ on 7/7/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

struct EmojiGameView: View {
    @ObservedObject var game: EmojiGame
    @State private var gameTime = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let cardAspectRatio: CGFloat = 2/3
    
    private var buttonOverlay: some View {
        let rectangle = RoundedRectangle(cornerRadius: 20.0)
        
        switch game.model.theme.color {
        case let .Solid(color):
            return AnyView(
                rectangle
                    .stroke(color.color, lineWidth: 5)
                    .foregroundColor(color.color)
            )
        case let .Gradient(gradientType):
            return AnyView(rectangle.stroke(gradientType.gradient, lineWidth: 5))
        }
    }
    
    var body: some View {
        VStack {
            Text("Points: \(game.model.points)")
            
            Text("Time: \(gameTime) seconds")
                .onReceive(timer) { _ in
                    self.gameTime += 1
                }
            
            Grid(items: game.cards) { card in
                CardView(card: card, theme: game.model.theme).onTapGesture {
                    withAnimation(.easeInOut) {
                        self.game.choose(card: card)
                    }
                }
                .aspectRatio(self.cardAspectRatio, contentMode: .fit)
                .padding()
            }
            .padding()
            
            Button(action: {
                withAnimation(.easeInOut) {
                    self.game.newGame()
                    self.gameTime = 0
                }
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
    var theme: EmojiTheme
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusTimeRemainingPercentage
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    private let fontScaleFactor: CGFloat = 0.7
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if (card.isConsumingBonusTime) {
                        Pie(
                            startAngle: Angle.degrees(-90),
                            endAngle: Angle.degrees(-animatedBonusRemaining * 360 - 90)
                        )
                        .onAppear {
                            self.startBonusTimeAnimation()
                        }
                    } else {
                        Pie(
                            startAngle: Angle.degrees(-90),
                            endAngle: Angle.degrees(-card.bonusTimeRemaining * 360 - 90)
                        )
                    }
                }
                .padding(5)
                .foregroundColor(.gray)
                .opacity(0.2)
                
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp, theme: theme)
            .font(Font.system(size: fontSize(for: size)))
            .transition(.scale)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiGame(theme: EmojiTheme())
        game.choose(card: game.cards[2])
        return EmojiGameView(game: game)
    }
}
