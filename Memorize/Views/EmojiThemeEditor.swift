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
    @Binding var theme: EmojiTheme
    @Binding var isShowing: Bool
    @State private var emojisToAdd: String = ""
    @State private var themeName: String = ""
    @State private var themeColor: ThemeColor = ThemeColor.Solid(CodableColor(color: .red))
    @State private var themeEmojis: [String] = []
    @State private var themeNbOfPairs: Int = 0
    
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
                    } label: {
                        Text("Done")
                    }
                    .padding()
                }
            }
            
            Divider()
            
            Form {
                Section {
                    TextField("Theme Name", text: $themeName)
                }
                
                Section(header: Text("Add Emojis")) {
                    HStack {
                        TextField("Emoji", text: $emojisToAdd)
                        Button {
                            themeEmojis.append(emojisToAdd)
                        } label: {
                            Text("Add")
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                Section(header: Text("Emojis")) {
                    Grid(themeEmojis, id: \.self) { emoji in
                        Text(emoji)
                            .font(Font.system(size: fontSize))
                            .onTapGesture {
                                themeEmojis.removeAll { $0 == emoji }
                            }
                    }
                    .frame(height: height)
                }
                
                Section(header: Text("Card Count")) {
                    HStack {
                        Stepper(
                            String(themeNbOfPairs) + " Pairs",
                            value: $themeNbOfPairs,
                            in: 1...8,
                            step: 1
                        )
                    }
                }
                
                Section(header: Text("Color")) {
                    SelectableThemeColorGrid(selectedThemeColor: colorOf(themeColor))
                }
            }.onAppear {
                themeName = theme.name
                themeEmojis = theme.emojis
                themeColor = theme.color
                themeNbOfPairs = theme.numberOfPairs
            }
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
    @State var selectedThemeColor: Color
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
            ForEach(EmojiTheme.availableThemeColors, id:\.self) { color in
                RoundedRectangle(cornerRadius: 10)
                    .fill(color)
                    .aspectRatio(1, contentMode: .fit)
                    .onTapGesture {
                        selectedThemeColor = color
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
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
            color: .Solid(CodableColor(color: .blue)),
            numberOfPairs: 4
        )
        
        EmojiThemeEditor(theme: Binding.constant(theme), isShowing: Binding.constant(true))
    }
}
