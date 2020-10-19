//
//  View+Cardify.swift
//  Memorize
//
//  Created by theswiftkid_ on 8/4/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

extension View {
    func cardify(isFaceUp: Bool, theme: Theme) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp, theme: theme))
    }
}
