//
//  EmojiThemeStore.swift
//  Memorize
//
//  Created by theswiftkid_ on 10/24/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI
import Combine

class EmojiThemeStore: ObservableObject {
    @Published var themes = [EmojiTheme]()

    private var themesAutosave: AnyCancellable?
    private let ThemesData = "Memorize.Themes"
    
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

    init() {
        let json =  UserDefaults.standard.data(forKey: ThemesData)
        if json != nil,
           let savedThemes = try? JSONDecoder().decode([EmojiTheme].self, from: json!) {
            // replace self from JSON input
           themes = savedThemes
        }

        themesAutosave = $themes.sink { newThemes in
            let json: Data = self.encodeThemes(newThemes)
            UserDefaults.standard.set(json, forKey: self.ThemesData)
        }
    }

    func addUntitledTheme() {
        withAnimation {
            themes.append(EmojiTheme.defaultTheme)
        }
    }

    func addTheme(_ theme: EmojiTheme) {
        themes.append(theme)
    }

    func addThemes(_ themes: [EmojiTheme]) {
        for theme in themes {
            addTheme(theme)
        }
    }
    
    func updateTheme(_ theme: EmojiTheme) {
        if let themeIndex = themes.firstIndex(of: theme) {
            themes[themeIndex].name = theme.name
            themes[themeIndex].color = theme.color
            themes[themeIndex].emojis = theme.emojis
            themes[themeIndex].numberOfPairs = theme.numberOfPairs
        }
    }

    func removeTheme(_ theme: EmojiTheme) {
        if let themeIndex = themes.firstIndex(of: theme) {
            themes.remove(at: themeIndex)
        }
    }
}
