//
//  Cardify.swift
//  Memorize
//
//  Created by theswiftkid_ on 8/4/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    var isFaceUp: Bool {
        rotation < 90 ? true : false
    }
    var theme: EmojiTheme
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 5
    
    init(isFaceUp: Bool, theme: EmojiTheme) {
        rotation = isFaceUp ? 0 : 180
        self.theme = theme
    }

    @ViewBuilder
    private func coloredShape<S: Shape>(shape: S) -> some View {
        switch theme.color {
        case let .Solid(color):
            shape.fill(color.color)
        case let .Gradient(gradientType):
            shape.fill(gradientType.gradient)
        }
    }

    private var CardBorder: some View {
        let rectangle = RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(lineWidth: edgeLineWidth)

        return coloredShape(shape: rectangle)
    }
    
    private var CardBack: some View {
        let rectangle = RoundedRectangle(cornerRadius: cornerRadius)

        return coloredShape(shape: rectangle)
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                CardBorder
                content
            }
            .opacity(isFaceUp ? 1 : 0)

            CardBack
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
}
