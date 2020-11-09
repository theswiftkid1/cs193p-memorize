//
//  UIColor+RGBA.swift
//  Memorize
//
//  Created by theswiftkid on 11/9/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

extension UIColor {
    public struct RGBA: Hashable, Codable {
        var red: CGFloat
        var green: CGFloat
        var blue: CGFloat
        var alpha: CGFloat
    }

    convenience init(_ rgba: RGBA) {
        self.init(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
    }

    public var rgba: RGBA {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return RGBA(red: red, green: green, blue: blue, alpha: alpha)
    }
}
