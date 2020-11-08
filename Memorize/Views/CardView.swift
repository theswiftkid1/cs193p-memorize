//
//  CardView.swift
//  Memorize
//
//  Created by theswiftkid on 11/6/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var card: GameModel<String>.Card
    var theme: EmojiTheme
    
    @State private var animatedBonusRemaining: Double = 0

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }

    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusTimeRemainingPercentage
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
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
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp, theme: theme)
            .transition(.scale)
        }
    }

    // MARK: Drawing Constants

    private let fontScaleFactor: CGFloat = 0.7

    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}
