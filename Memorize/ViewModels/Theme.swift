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

extension ThemeColor: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .Solid(let color):
            try container.encode(color)
        case .Gradient(let gradient):
            try container.encode(gradient)
        }
    }
}

extension Color: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.description)
    }
}

extension AngularGradient: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode("rainbow gradient")
    }
}

struct Theme: Encodable {
    var name: String
    var emojis: [String]
    var color: ThemeColor
    var numberOfPairs: Int

    fileprivate init(name: String,
                     emojis: [String],
                     color: ThemeColor,
                     numberOfPairs: Int) {
        self.name = name
        self.emojis = emojis
        self.color = color
        self.numberOfPairs = numberOfPairs
    }

    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
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
