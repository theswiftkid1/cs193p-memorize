//
//  EmojiTheme.swift
//  Memorize
//
//  Created by theswiftkid on 11/5/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

struct EmojiTheme: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var emojis: [String]
    var color: ThemeColor
    var numberOfPairs: Int
    
    static let defaultTheme = EmojiTheme(
        name: "Untitled",
        emojis: [],
        color: .Solid(CodableColor(color: .gray)),
        numberOfPairs: 0
    )
    
    static let availableThemeColors: [Color] = [
        .red,
        .blue,
        .green,
        .gray,
        .purple,
        .pink,
        .orange,
        .black
    ]
    
    // MARK: Init
    
    init(name: String,
         emojis: [String],
         color: ThemeColor,
         numberOfPairs: Int) {
        self.name = name
        self.emojis = emojis
        self.color = color
        self.numberOfPairs = numberOfPairs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        emojis = try container.decode(Array<String>.self, forKey: .emojis)
        color = try container.decode(ThemeColor.self, forKey: .color)
        numberOfPairs = try container.decode(Int.self, forKey: .numberOfPairs)
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
}
