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
    
    private var CardBorder: some View {
        let rectangle = RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(lineWidth: edgeLineWidth)
        
        switch theme.color {
        case let .Solid(color):
            return AnyView(rectangle.fill(color))
        case let .Gradient(gradientType):
            return AnyView(rectangle.fill(gradientType.gradient))
        }
    }
    
    private var CardBack: some View {
        let rectangle = RoundedRectangle(cornerRadius: cornerRadius)
        
        switch theme.color {
        case let .Solid(color):
            return AnyView(rectangle.fill(color))
        case let .Gradient(gradientType):
            return AnyView(rectangle.fill(gradientType.gradient))
        }
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
