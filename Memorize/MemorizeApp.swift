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
    private let store = EmojiThemeStore()

    private let themes = [
        EmojiTheme(
            name: "Emojis",
            emojis: ["😇","😎","😘","😁","🧐","🥳","🤩"],
            color: .Solid(CodableColor(rgbaColor: UIColor.systemBlue.rgba)),
            numberOfPairs: 4
        ),
        EmojiTheme(
            name: "Places",
            emojis: ["🌇","🎇","🌄","🌌","🌉","🌅","🏞"],
            color: .Solid(CodableColor(rgbaColor: UIColor.systemGreen.rgba)),
            numberOfPairs: 3
        ),
        EmojiTheme(
            name: "Fire",
            emojis: ["💯","❗️","♥️","🚩","🎈","💥","🔥"],
            color: .Solid(CodableColor(rgbaColor: UIColor.systemRed.rgba)),
            numberOfPairs: 6
        ),
        EmojiTheme(
            name: "Apple",
            emojis: ["👨‍💻","👩‍💻","📱","💻","🖥","🖱","⌨️"],
            color: .Solid(CodableColor(rgbaColor: UIColor.systemGray.rgba)),
            numberOfPairs: 5
        ),
        EmojiTheme(
            name: "Music",
            emojis: ["👩‍🎤","🎸","🎤","🎻","🎺","🥁","👨‍🎤"],
            color: .Solid(CodableColor(rgbaColor: UIColor.systemPurple.rgba)),
            numberOfPairs: 4
        ),
        EmojiTheme(
            name: "Black and yellow",
            emojis: ["🖤","♣️","🏴","♠️","🕶","🎱","☕️"],
            color: .Solid(CodableColor(rgbaColor: UIColor.systemYellow.rgba)),
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
        if (store.themes.isEmpty) {
            store.addThemes(themes)
        }
    }

    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(store)
        }
    }
}
