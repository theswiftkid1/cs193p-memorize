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
    @State private(set) var theme: EmojiTheme

    @EnvironmentObject private var store: EmojiThemeStore

    @Binding var isShowing: Bool

    @State private var name: String = ""
    @State private var numberOfPairs: Int = 0
    @State private var emojis: Set<String> = .init()
    @State private var color: Color = .black
    @State private var selectableColors = EmojiTheme.availableThemeColors
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
                    Text(theme.name)
                        .font(.headline)
                        .padding()
                    Spacer()
                    Button {
                        isShowing = false
                        print("Saving name \(name)")
                        theme.name = name
                        theme.color = ThemeColor.Solid(CodableColor(color: color))
                        theme.emojis = Array(emojis)
                        theme.numberOfPairs = numberOfPairs
                        store.updateTheme(theme)
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
                                
                                emojisToAdd.forEach { emoji in
                                    self.emojis.insert(String(emoji))
                                }
                            }
                        } label: {
                            Text("Add")
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                Section(header: Text("Emojis")) {
                    Grid(Array(emojis), id: \.self) { emoji in
                        Text(emoji)
                            .font(Font.system(size: fontSize))
                            .onTapGesture {
                                withAnimation {
                                    emojis = emojis.filter { $0 == emoji }
                                }
                            }
                    }
                    .frame(height: height)
                }
                
                Section(header: Text("Card Count")) {
                    HStack {
                        Stepper(
                            "\(numberOfPairs) Pairs",
                            value: $numberOfPairs,
                            in: 1...8,
                            step: 1
                        )
                    }
                }
                
                Section(header: Text("Color")) {
                    SelectableThemeColorGrid(selectableColors: selectableColors, selectedThemeColor: color)
                }
            }
        }
        .onAppear {
            name = theme.name
            numberOfPairs = theme.numberOfPairs
            emojis = Set(theme.emojis)
            // /!\ Problem here because of encoding/decoding with UIColor which gives a different UIExtendedSRGBColorSpace instead of a wanted simple color
            color = colorOf(theme.color)
        }
    }
    
    func colorOf(_ theme: ThemeColor) -> Color {
        switch theme {
        case .Solid(let codableColor):
            return codableColor.color
        default:
            return .black
        }
    }
}

struct SelectableThemeColorGrid: View {
    private(set) var selectableColors: [Color]
    @State var selectedThemeColor: Color
    
    private let cornerRadius = CGFloat(10)

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
            ForEach(selectableColors, id:\.self) { color in
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(color)
                    .aspectRatio(1, contentMode: .fit)
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.1)) {
                            selectedThemeColor = color
                        }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(Color.black, lineWidth: selectedThemeColor == color ? 3 : 0)
//                            .onAppear {
//                                print("Theme Color <\(selectedThemeColor)> | Color <\(Color(UIColor(color)))> | Equals <\(selectedThemeColor == Color(UIColor(color)))>")
//                            }
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
            color: .Solid(CodableColor(color: .blue)),
            numberOfPairs: 4
        )
        
        EmojiThemeEditor(theme: theme, isShowing: Binding.constant(true))
    }
}
