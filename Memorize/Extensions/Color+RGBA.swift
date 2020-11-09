//
//  Color+RGBA.swift
//  Memorize
//
//  Created by theswiftkid on 11/9/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

extension Color {

    init(_ rgba: UIColor.RGBA) {
        self.init(UIColor(rgba))
    }
}
