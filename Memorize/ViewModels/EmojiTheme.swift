//
//  ThemeGenerator.swift
//  Memorize
//
//  Created by theswiftkid_ on 7/31/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

enum ThemeGradient {
    case Rainbow

    var gradient: AngularGradient {
        switch self {
        case .Rainbow: return AngularGradient(
            gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .red]),
            center: .center
        )
        }
    }
}

extension ThemeGradient: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .Rainbow:
            try container.encode("rainbow")
        }
    }
}

enum ThemeColor {
    case Solid(Color)
    case Gradient(ThemeGradient)
}

extension ThemeColor: Encodable, Hashable {
    static func == (lhs: ThemeColor, rhs: ThemeColor) -> Bool {
        switch (lhs, rhs) {
        case (.Solid, .Solid), (.Gradient, .Gradient):
            return true
        default:
            return false
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .Solid(let color):
            try container.encode(color)
        case .Gradient(let gradient):
            try container.encode(gradient)
        }
    }
}

extension Color: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.description)
    }
}

struct EmojiTheme: Encodable, Hashable, Identifiable {
    var id: UUID
    var name: String
    var emojis: [String]
    var color: ThemeColor
    var numberOfPairs: Int

    init(id: UUID? = nil) {
        self.id = id ?? UUID()
        //        let defaultsKey = "EmojiTheme.\(self.id)"
        //        initFromStore(json: UserDefaults.standard.data(forKey: defaultsKey))
        self.name = "name"
        self.emojis = [""]
        self.color = .Solid(.red)
        self.numberOfPairs = 0
    }

    //    private func initFromStore(json: Data?) {
    //
    //    }

    init(id: UUID? = nil,
         name: String,
         emojis: [String],
         color: ThemeColor,
         numberOfPairs: Int) {
        self.id = id ?? UUID()
        self.name = name
        self.emojis = emojis
        self.color = color
        self.numberOfPairs = numberOfPairs
        let defaultsKey = "EmojiTheme.\(self.id)"
        UserDefaults.standard.set(json, forKey: defaultsKey)
    }

    static func == (lhs: EmojiTheme, rhs: EmojiTheme) -> Bool {
        lhs.id == rhs.id
    }

    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
}
