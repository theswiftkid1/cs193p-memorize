//
//  ThemeGenerator.swift
//  Memorize
//
//  Created by theswiftkid_ on 7/31/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

class EmojiTheme: ObservableObject, Codable, Hashable, Identifiable {
    var id: UUID
    @Published var name: String
    @Published var emojis: [String]
    @Published var color: ThemeColor
    @Published var numberOfPairs: Int
    
    // MARK: Init

    init(id: UUID? = nil) {
        self.id = id ?? UUID()
        let userDefaultsKey = "EmojiTheme.\(self.id.uuidString)"
        let json = UserDefaults.standard.data(forKey: userDefaultsKey)
        if json != nil, let newEmojiTheme = try? JSONDecoder().decode(EmojiTheme.self, from: json!) {
            self.name = newEmojiTheme.name
            self.emojis = newEmojiTheme.emojis
            self.color = newEmojiTheme.color
            self.numberOfPairs = newEmojiTheme.numberOfPairs
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
    
    // MARK: Codable
    
    enum CodingKeys: CodingKey {
        case id, name, emojis, color, numberOfPairs
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(emojis, forKey: .emojis)
        try container.encode(color, forKey: .color)
        try container.encode(numberOfPairs, forKey: .numberOfPairs)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        emojis = try container.decode(Array<String>.self, forKey: .emojis)
        color = try container.decode(ThemeColor.self, forKey: .color)
        numberOfPairs = try container.decode(Int.self, forKey: .numberOfPairs)
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }

    
    // MARK: Identifiable

    static func == (lhs: EmojiTheme, rhs: EmojiTheme) -> Bool {
        lhs.id == rhs.id
    }
    
    // MARK: Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(emojis)
        hasher.combine(color)
        hasher.combine(numberOfPairs)
    }
    
    // MARK: Actions
    
    func setName(to name: String) {
        self.name = name
    }

    func addEmojis(_ emojis: [String]) {
        self.emojis += emojis
    }

    func removeEmoji(_ emoji: String) {
        self.emojis = emojis.filter { $0 != emoji }
    }

    func incrementNumberOfPairs(by number: Int = 1) {
        self.numberOfPairs += number
    }

    func decrementNumberOfPairs(by number: Int = 1) {
        self.numberOfPairs -= number
    }
}
