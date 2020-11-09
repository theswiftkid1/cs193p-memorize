//
//  ThemeEditor.swift
//  Memorize
//
//  Created by theswiftkid on 10/26/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI
import Foundation

struct EmojiThemeEditor: View {
    @EnvironmentObject private var store: EmojiThemeStore
    
    private(set) var theme: EmojiTheme
    
    @Binding var isShowing: Bool
    
    @State private var name: String = ""
    @State private var numberOfPairs: Int = 0
    @State private var emojis: Set<String> = ["😁"]
    @State private var color: ThemeColor = ThemeColor.defaultColor
    @State private var emojisToAdd: String = ""

    let fontSize: CGFloat = 40
    var height: CGFloat {
        CGFloat((theme.emojis.count - 1) / 6 * 70 + 70)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Button {
                        isShowing = false
                    } label: {
                        Text("Cancel")
                    }
                    .padding()
                    Spacer()
                    Text(name)
                        .font(.headline)
                        .padding()
                    Spacer()
                    Button {
                        isShowing = false
                        store.updateTheme(
                            theme: theme,
                            name: name,
                            color: color,
                            emojis: Array(emojis),
                            numberOfPairs: numberOfPairs
                        )
                    } label: {
                        Text("Done")
                    }
                    .padding()
                }
            }
            
            Divider()
            
            Form {
                Section {
                    TextField("Theme Name", text: $name)
                }
                
                Section(header: Text("Add Emojis")) {
                    HStack {
                        TextField("Emoji", text: $emojisToAdd)
                        Button {
                            withAnimation {
                                // TODO: should check if added character is actually emoji
                                emojisToAdd.forEach { emoji in
                                    emojis.insert(String(emoji))
                                }
                                emojisToAdd = ""
                            }
                        } label: {
                            Text("Add")
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                Section(header: Text("Emojis")) {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
                        ForEach(Array(emojis), id:\.self) { emoji in
                            Text(emoji)
                                .font(Font.system(size: fontSize))
                                .onTapGesture {
                                    if (emojis.count > 1) {
                                        withAnimation {
                                            emojis = emojis.filter { $0 != emoji }
                                            numberOfPairs = numberOfPairs > emojis.count ? emojis.count : numberOfPairs
                                        }
                                    }
                                }
                        }
                    }
                }
                
                Section(header: Text("Card Count")) {
                    HStack {
                        Stepper(
                            "\(numberOfPairs) Pairs",
                            value: $numberOfPairs,
                            in: 1...emojis.count,
                            step: 1
                        )
                    }
                }
                
                Section(header: Text("Color")) {
                    SelectableThemeColorGrid(selectedThemeColor: $color)
                }
            }
        }
        .onAppear {
            name = theme.name
            numberOfPairs = theme.numberOfPairs
            emojis = Set(theme.emojis)
            color = theme.color
        }
    }
}

struct SelectableThemeColorGrid: View {
    private(set) var selectableColors: [ThemeColor] = ThemeColor.allCases
    @Binding var selectedThemeColor: ThemeColor
    
    private let cornerRadius = CGFloat(10)

    @ViewBuilder
    private func colorView(color: ThemeColor) -> some View {
        switch color {
            case .Solid(let codableColor):
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(codableColor.color)
            case .Gradient(let codableGradient):
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(codableGradient.gradient)
        }
    }

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
            ForEach(selectableColors, id:\.id) { color in
                colorView(color: color)
                    .aspectRatio(1, contentMode: .fit)
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.1)) {
                            selectedThemeColor = color
                        }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(Color.black, lineWidth: selectedThemeColor == color ? 3 : 0)
                    )
            }
        }
    }
}

struct EmojiThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        let theme = EmojiTheme(
            name: "Emojis",
            emojis: ["😇","😎","😘","😁","🧐","🥳","🤩"],
            color: ThemeColor.defaultColor,
            numberOfPairs: 4
        )
        
        EmojiThemeEditor(theme: theme, isShowing: Binding.constant(true))
    }
}
