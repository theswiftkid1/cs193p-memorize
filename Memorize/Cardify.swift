//
//  Cardify.swift
//  Memorize
//
//  Created by theswiftkid_ on 8/4/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    var theme: Theme
    
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 5
    

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
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                CardBorder
                content
            } else {
                CardBack
            }
        }
    }
}
