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
    let name: String

    @Published private var themeNames = [EmojiTheme:String]()
    private var themesAutosave: AnyCancellable?

    init(named name: String = "Memorize") {
        self.name = name
        let defaultsKey = "Memorize.\(name)"
        themeNames = Dictionary(fromPropertyList: UserDefaults.standard.object(forKey: defaultsKey))
        themesAutosave = $themeNames.sink { names in
            UserDefaults.standard.set(names.asPropertyList, forKey: defaultsKey)
        }
    }

    func name(for theme: EmojiTheme) -> String {
        if themeNames[theme] == nil {
            themeNames[theme] = "Untitled"
        }
        return themeNames[theme]!
    }

    func setName(_ name: String, for theme: EmojiTheme) {
        themeNames[theme] = name
    }

    var themes: [EmojiTheme] {
        themeNames.keys.sorted { themeNames[$0]! < themeNames[$1]! }
    }

    func addTheme(named name: String = "Untitled") {
        themeNames[EmojiTheme()] = name
    }

    func addThemes(_ themes: [EmojiTheme]) {
        for theme in themes {
            themeNames[theme] = theme.name
        }
    }

    func removeTheme(_ theme: EmojiTheme) {
        themeNames[theme] = nil
    }
}

extension Dictionary where Key == EmojiTheme, Value == String {
    var asPropertyList: [String:String] {
        var uuidToName = [String:String]()
        for (key, value) in self {
            uuidToName[key.id.uuidString] = value
        }
        return uuidToName
    }

    init(fromPropertyList plist: Any?) {
        self.init()
        let uuidToName = plist as? [String:String] ?? [:]
        for uuid in uuidToName.keys {
            self[EmojiTheme(id: UUID(uuidString: uuid))] = uuidToName[uuid]
        }
    }
}
