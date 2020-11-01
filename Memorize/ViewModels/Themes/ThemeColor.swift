//
//  ThemeColor.swift
//  Memorize
//
//  Created by theswiftkid on 10/25/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

// MARK: - ThemeGradient

enum ThemeGradient: String, Codable {
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

// MARK: - CodableColor

public struct CodableColor: Codable, Hashable {
    let uiColor: UIColor
    let color: Color
        
    init(color: Color) {
        self.color = color
        self.uiColor = UIColor(color)
    }
    
    public func encode(to encoder: Encoder) throws {
        let nsCoder = NSKeyedArchiver(requiringSecureCoding: true)
        uiColor.encode(with: nsCoder)
        var container = encoder.unkeyedContainer()
        try container.encode(nsCoder.encodedData)
    }

    private enum ColorCodingError: Error {
        case decoding(String)
    }

    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let decodedData = try container.decode(Data.self)
        let nsCoder = try NSKeyedUnarchiver(forReadingFrom: decodedData)
        guard let uiColor = UIColor(coder: nsCoder) else {
            throw ColorCodingError.decoding("Color decoding error")
        }
        self.uiColor = uiColor
        self.color = Color(uiColor)
    }
}

// MARK: - ThemeColor

let selectableColors: [Color] = [
    .red,
    .blue,
    .green,
    .gray,
    .purple,
    .black
]

enum ThemeColor {
    case Solid(CodableColor)
    case Gradient(ThemeGradient)
}

extension ThemeColor: Codable, Hashable {
    static func == (lhs: ThemeColor, rhs: ThemeColor) -> Bool {
        switch (lhs, rhs) {
        case (.Solid, .Solid), (.Gradient, .Gradient):
            return true
        default:
            return false
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case solid
        case gradient
    }
    
    enum ThemeColorCodingError: Error {
        case decoding(String)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? values.decode(CodableColor.self, forKey: .solid) {
            self = .Solid(value)
            return
        }
        if let value = try? values.decode(ThemeGradient.self, forKey: .gradient) {
            self = .Gradient(value)
            return
        }
        throw ThemeColorCodingError.decoding("Couldn't decode theme color \(dump(values))")
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .Solid(let color):
            try container.encode(color, forKey: .solid)
        case .Gradient(let gradient):
            try container.encode(gradient, forKey: .gradient)
        }
    }
}
