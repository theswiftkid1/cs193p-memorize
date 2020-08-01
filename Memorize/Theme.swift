//
//  ThemeGenerator.swift
//  Memorize
//
//  Created by theswiftkid_ on 7/31/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

struct Theme {
    var name: String
    var emojis: [String]
    var color: Color
}

let themes = [
    Theme(name: "Emojis", emojis: ["😇","😎","😘","😁","🧐","🥳","🤩"], color: .blue),
    Theme(name: "Places", emojis: ["🌇","🎇","🌄","🌌","🌉","🌅","🏞"], color: .green),
    Theme(name: "Fire", emojis: ["💯","❗️","♥️","🚩","🎈","💥","🔥"], color: .red),
    Theme(name: "Apple", emojis: ["👨‍💻","👩‍💻","📱","💻","🖥","🖱","⌨️"], color: .gray),
    Theme(name: "Music", emojis: ["👩‍🎤","🎸","🎤","🎻","🎺","🥁","👨‍🎤"], color: .purple),
    Theme(name: "Dark", emojis: ["🖤","♣️","🏴","♠️","🕶","🎱","☕️"], color: .black),
]
