//
//  MemorizeApp.swift
//  Memorize
//
//  Created by theswiftkid_ on 10/19/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let store = EmojiThemeStore(named: "Memorize")

    private let themes = [
        EmojiTheme(
            name: "Emojis",
            emojis: ["😇","😎","😘","😁","🧐","🥳","🤩"],
            color: .Solid(.blue),
            numberOfPairs: 4
        ),
        EmojiTheme(
            name: "Places",
            emojis: ["🌇","🎇","🌄","🌌","🌉","🌅","🏞"],
            color: .Solid(.green),
            numberOfPairs: 3
        ),
        EmojiTheme(
            name: "Fire",
            emojis: ["💯","❗️","♥️","🚩","🎈","💥","🔥"],
            color: .Solid(.red),
            numberOfPairs: 6
        ),
        EmojiTheme(
            name: "Apple",
            emojis: ["👨‍💻","👩‍💻","📱","💻","🖥","🖱","⌨️"],
            color: .Solid(.gray),
            numberOfPairs: 5
        ),
        EmojiTheme(
            name: "Music",
            emojis: ["👩‍🎤","🎸","🎤","🎻","🎺","🥁","👨‍🎤"],
            color: .Solid(.purple),
            numberOfPairs: 4
        ),
        EmojiTheme(
            name: "Dark",
            emojis: ["🖤","♣️","🏴","♠️","🕶","🎱","☕️"],
            color: .Solid(.black),
            numberOfPairs: 4
        ),
        EmojiTheme(
            name: "Rainbow",
            emojis: ["🌈","🏳️‍🌈","🌧","☀️","☃️","🍁","⛱"],
            color: .Gradient(.Rainbow),
            numberOfPairs: 6
        ),
    ]

    init() {
        store.addThemes(themes)
    }

    var body: some Scene {
        WindowGroup {
            EmojiThemeChooser().environmentObject(store)
        }
    }
}
