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
                    gameTime += 1
                }

            Grid(game.cards) { card in
                CardView(card: card, theme: game.model.theme).onTapGesture {
                    withAnimation(.easeInOut) {
                        game.choose(card: card)
                    }
                }
                .aspectRatio(cardAspectRatio, contentMode: .fit)
                .padding(10)
            }
            .padding()

            Button(action: {
                withAnimation(.easeInOut) {
                    game.newGame()
                    gameTime = 0
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

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiGame(theme: EmojiTheme(
            name: "Untitled",
            emojis: [],
            color: ThemeColor.defaultColor,
            numberOfPairs: 0
        ))
        game.choose(card: game.cards[2])
        return EmojiGameView(game: game)
    }
}
