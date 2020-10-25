//
//  ThemeGenerator.swift
//  Memorize
//
//  Created by theswiftkid_ on 7/31/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

struct EmojiTheme: Codable, Hashable, Identifiable {
    var id: UUID
    var name: String
    var emojis: [String]
    var color: ThemeColor
    var numberOfPairs: Int

    init(id: UUID? = nil) {
        self.id = id ?? UUID()
        let userDefaultsKey = "EmojiTheme.\(self.id.uuidString)"
        let json = UserDefaults.standard.data(forKey: userDefaultsKey)
        print("Initializing from json: \(json!)")
        if json != nil, let newEmojiTheme = try? JSONDecoder().decode(EmojiTheme.self, from: json!) {
            self = newEmojiTheme
        } else {
            self.name = "Untitled"
            self.emojis = []
            self.color = .Solid(CodableColor(color: .red))
            self.numberOfPairs = 0
        }
    }
    
    init(name: String,
         emojis: [String],
         color: ThemeColor,
         numberOfPairs: Int) {
        self.id = UUID()
        self.name = name
        self.emojis = emojis
        self.color = color
        self.numberOfPairs = numberOfPairs
        let userDefaultsKey = "EmojiTheme.\(self.id.uuidString)"
        UserDefaults.standard.set(self.json, forKey: userDefaultsKey)
    }
    
    static func == (lhs: EmojiTheme, rhs: EmojiTheme) -> Bool {
        lhs.id == rhs.id
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
}
