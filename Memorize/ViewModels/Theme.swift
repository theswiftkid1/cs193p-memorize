//
//  ThemeGenerator.swift
//  Memorize
//
//  Created by theswiftkid_ on 7/31/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

enum ThemeColor {
    case Solid(Color)
    case Gradient(AngularGradient)
}

struct Theme {
    var name: String
    var emojis: [String]
    var color: ThemeColor
}

let themes = [
    Theme(name: "Emojis", emojis: ["😇","😎","😘","😁","🧐","🥳","🤩"], color: ThemeColor.Solid(.blue)),
    Theme(name: "Places", emojis: ["🌇","🎇","🌄","🌌","🌉","🌅","🏞"], color: ThemeColor.Solid(.green)),
    Theme(name: "Fire", emojis: ["💯","❗️","♥️","🚩","🎈","💥","🔥"], color: ThemeColor.Solid(.red)),
    Theme(name: "Apple", emojis: ["👨‍💻","👩‍💻","📱","💻","🖥","🖱","⌨️"], color: ThemeColor.Solid(.gray)),
    Theme(name: "Music", emojis: ["👩‍🎤","🎸","🎤","🎻","🎺","🥁","👨‍🎤"], color: ThemeColor.Solid(.purple)),
    Theme(name: "Dark", emojis: ["🖤","♣️","🏴","♠️","🕶","🎱","☕️"], color: ThemeColor.Solid(.black)),
    Theme(
        name: "Rainbow",
        emojis: ["🌈","🏳️‍🌈","🌧","☀️","☃️","🍁","⛱"],
        color: ThemeColor.Gradient(AngularGradient(
            gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .red]),
            center: .center
        ))
    ),
]
