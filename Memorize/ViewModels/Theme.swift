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
    var numberOfPairs: Int
}

let themes = [
    Theme(
        name: "Emojis",
        emojis: ["😇","😎","😘","😁","🧐","🥳","🤩"],
        color: ThemeColor.Solid(.blue),
        numberOfPairs: 4
    ),
    Theme(name: "Places",
          emojis: ["🌇","🎇","🌄","🌌","🌉","🌅","🏞"],
          color: ThemeColor.Solid(.green),
          numberOfPairs: 3
    ),
    Theme(name: "Fire",
          emojis: ["💯","❗️","♥️","🚩","🎈","💥","🔥"],
          color: ThemeColor.Solid(.red),
          numberOfPairs: 6
    ),
    Theme(name: "Apple",
          emojis: ["👨‍💻","👩‍💻","📱","💻","🖥","🖱","⌨️"],
          color: ThemeColor.Solid(.gray),
          numberOfPairs: 5
    ),
    Theme(name: "Music",
          emojis: ["👩‍🎤","🎸","🎤","🎻","🎺","🥁","👨‍🎤"],
          color: ThemeColor.Solid(.purple),
          numberOfPairs: 4
    ),
    Theme(name: "Dark",
          emojis: ["🖤","♣️","🏴","♠️","🕶","🎱","☕️"],
          color: ThemeColor.Solid(.black),
          numberOfPairs: 4
    ),
    Theme(
        name: "Rainbow",
        emojis: ["🌈","🏳️‍🌈","🌧","☀️","☃️","🍁","⛱"],
        color: ThemeColor.Gradient(AngularGradient(
            gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .red]),
            center: .center
        )),
        numberOfPairs: 6
    ),
]
