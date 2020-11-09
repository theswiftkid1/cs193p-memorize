//
//  ThemeColor.swift
//  Memorize
//
//  Created by theswiftkid on 10/25/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

// MARK: - CodableGradient

enum CodableGradient: String, Codable {
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
    let rgbaColor: UIColor.RGBA
    var color: Color {
        Color(UIColor(rgbaColor))
    }
}

// MARK: - ThemeColor

enum ThemeColor: CaseIterable, Identifiable {
    var id: Int { hashValue }

    static let defaultColor: ThemeColor =
        .Solid(CodableColor(rgbaColor: UIColor.red.rgba))

    static var allCases: [ThemeColor] = [
        .Solid(CodableColor(rgbaColor: UIColor.systemRed.rgba)),
        .Solid(CodableColor(rgbaColor: UIColor.systemGreen.rgba)),
        .Solid(CodableColor(rgbaColor: UIColor.systemBlue.rgba)),
        .Solid(CodableColor(rgbaColor: UIColor.systemYellow.rgba)),
        .Solid(CodableColor(rgbaColor: UIColor.systemPink.rgba)),
        .Solid(CodableColor(rgbaColor: UIColor.systemOrange.rgba)),
        .Solid(CodableColor(rgbaColor: UIColor.systemGray.rgba)),
        .Gradient(.Rainbow),
    ]

    case Solid(CodableColor)
    case Gradient(CodableGradient)
}

extension ThemeColor: Codable, Hashable {

    static func == (lhs: ThemeColor, rhs: ThemeColor) -> Bool {
        lhs.id == rhs.id
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
        if let value = try? values.decode(CodableGradient.self, forKey: .gradient) {
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
