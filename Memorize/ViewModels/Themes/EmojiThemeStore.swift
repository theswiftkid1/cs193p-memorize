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
    
    init() {
        themes = loadThemes(json: UserDefaults.standard.data(forKey: ThemesData)) ?? []

        themesAutosave = $themes.sink { themes in
            let json: Data = self.encodeThemes(themes)
            UserDefaults.standard.set(json, forKey: self.ThemesData)
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

    func loadThemes(json: Data?) -> [EmojiTheme]? {
        if json != nil,
           let savedThemes = try? JSONDecoder().decode([EmojiTheme].self, from: json!) {
            // replace self from JSON input
            return savedThemes
        } else {
            return nil
        }
    }

    // MARK: Actions

    func addUntitledTheme() {
        themes.append(EmojiTheme.defaultTheme)
    }

    func addTheme(_ theme: EmojiTheme) {
        themes.append(theme)
    }

    func addThemes(_ themes: [EmojiTheme]) {
        for theme in themes {
            addTheme(theme)
        }
    }

    func findTheme(_ theme: EmojiTheme) -> EmojiTheme? {
        if let themeIndex = themes.firstIndex(of: theme) {
            return themes[themeIndex]
        }
        return nil
    }

    public func updateTheme(theme: EmojiTheme,
                            name: String,
                            color: ThemeColor,
                            emojis: [String],
                            numberOfPairs: Int) {
        if let themeIndex = themes.firstIndex(of: theme) {
            themes[themeIndex].name = name
            themes[themeIndex].color = color
            themes[themeIndex].emojis = emojis
            themes[themeIndex].numberOfPairs = numberOfPairs
        }
    }

    func removeTheme(_ theme: EmojiTheme) {
        if let themeIndex = themes.firstIndex(of: theme) {
            themes.remove(at: themeIndex)
        }
    }
}
