//
//  ThemeEditor.swift
//  Memorize
//
//  Created by theswiftkid on 10/26/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

struct EmojiThemeEditor: View {
    @State var theme: EmojiTheme
    @Binding var isShowing: Bool
    @State private var themeName: String = ""
    @State private var emojisToAdd: String = ""
    
    let fontSize: CGFloat = 40
    var height: CGFloat {
        CGFloat((theme.emojis.count - 1) / 6 * 70 + 70)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text(theme.name)
                    .font(.headline)
                    .padding()
                HStack {
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
                    TextField("Theme Name", text: $theme.name)
                }
                
                Section(header: Text("Add Emojis")) {
                    HStack {
                        TextField("Emoji", text: $emojisToAdd)
                        Button {
                            theme.addEmojis(Array(arrayLiteral: emojisToAdd))
                        } label: {
                            Text("Add")
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                Section(header: Text("Emojis")) {
                    Grid(theme.emojis, id: \.self) { emoji in
                        Text(emoji)
                            .font(Font.system(size: fontSize))
                            .onTapGesture {
                                theme.removeEmoji(emoji)
                            }
                    }
                    .frame(height: height)
                }
                
                Section(header: Text("Card Count")) {
                    HStack {
                        Text(String(theme.numberOfPairs) + " Pairs")
                        Stepper(
                            onIncrement: {
                                theme.incrementNumberOfPairs()
                            },
                            onDecrement: {
                                theme.decrementNumberOfPairs()
                            },
                            label: {
                                EmptyView()
                            }
                        )
                    }
                }
                
                Section(header: Text("Color")) {
                    Grid(selectableColors, id: \.self) { selectableColor in
                        SelectableColorView(theme: theme, color: selectableColor)
                            .onTapGesture {
                                theme.selectColor(selectableColor)
                            }
                    }
                    .frame(height: height)
                }
            }.onAppear {
                themeName = theme.name
            }
        }
    }
}

struct SelectableColorView: View {
    var theme: EmojiTheme
    var color: Color

    @ViewBuilder
    private func selected() -> some View {
        switch theme.color {
        case .Solid(let themeColor) where themeColor.color == color:
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(lineWidth: 3)
                .foregroundColor(.black)
        case _:
            EmptyView()
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(color)
            
            selected()
        }
        .padding()
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
