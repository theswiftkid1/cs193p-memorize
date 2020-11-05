//
//  ThemeGenerator.swift
//  Memorize
//
//  Created by theswiftkid_ on 7/31/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

struct EmojiThemesManager {
    var themes: [EmojiTheme]
    
    // MARK: Init

    init() {
        themes = []
    }
    
    init?(json: Data?) {
        if json != nil,
           let savedThemes = try? JSONDecoder().decode([EmojiTheme].self, from: json!) {
            // replace self from JSON input
           themes = savedThemes
        } else {
           return nil
        }
    }

    // MARK: Actions
    
    mutating func addUntitledTheme() {
        themes.append(EmojiTheme.defaultTheme)
    }

    mutating func addTheme(_ theme: EmojiTheme) {
        themes.append(theme)
    }

    mutating func addThemes(_ themes: [EmojiTheme]) {
        for theme in themes {
            addTheme(theme)
        }
    }
    
    mutating func updateTheme(_ theme: EmojiTheme) {
        if let themeIndex = themes.firstIndex(of: theme) {
            themes[themeIndex].name = theme.name
            themes[themeIndex].color = theme.color
            themes[themeIndex].emojis = theme.emojis
            themes[themeIndex].numberOfPairs = theme.numberOfPairs
        }
    }

    mutating func removeTheme(_ theme: EmojiTheme) {
        if let themeIndex = themes.firstIndex(of: theme) {
            themes.remove(at: themeIndex)
        }
    }

    // MARK: Utilities
    
    func encodeThemes<T: Encodable>(_ themes: T) -> Data {
        var json : Data
        do {
            let encoder = JSONEncoder()
            json = try encoder.encode(themes)
        } catch {
            fatalError("Couldn't encode the list of themes as \(T.self):\n\(error)")
        }
        return json
    }
}
