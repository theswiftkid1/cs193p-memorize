//
//  ThemeEditor.swift
//  Memorize
//
//  Created by theswiftkid on 10/26/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

struct EmojiThemeEditor: View {
    @ObservedObject var theme: EmojiTheme
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
                    TextField("Theme Name", text: $themeName) { began in
                        if !began {
                            theme.setName(to: themeName)
                        }
                    }
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
//                    Grid(theme., id: \.self) { emoji in
//                        Text(emoji)
//                            .font(Font.system(size: fontSize))
//                            .onTapGesture {
//                                theme.removeEmoji(emoji)
//                            }
//                    }
//                    .frame(height: height)
                }
            }.onAppear {
                themeName = theme.name
            }
        }
    }
}

//struct ThemeEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeEditor()
//    }
//}
