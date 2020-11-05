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
    @Published var themesManager: EmojiThemesManager

    private var themesAutosave: AnyCancellable?
    private let ThemesData = "Memorize.Themes"
    
    init() {
        themesManager = EmojiThemesManager(json: UserDefaults.standard.data(forKey: ThemesData)) ?? EmojiThemesManager()

        themesAutosave = $themesManager.sink { manager in
            let json: Data = manager.encodeThemes(manager.themes)
            UserDefaults.standard.set(json, forKey: self.ThemesData)
        }
    }
    
    // MARK: Variables
    
    var themes: [EmojiTheme] {
        themesManager.themes
    }
    
    // MARK: Actions
    
    func addUntitledTheme() {
        themesManager.addUntitledTheme()
    }

    func addTheme(_ theme: EmojiTheme) {
        themesManager.addTheme(theme)
    }

    func addThemes(_ newThemes: [EmojiTheme]) {
        themesManager.addThemes(newThemes)
    }
    
    func updateTheme(_ theme: EmojiTheme) {
        themesManager.updateTheme(theme)
    }

    func removeTheme(_ theme: EmojiTheme) {
        themesManager.removeTheme(theme)
    }
}
