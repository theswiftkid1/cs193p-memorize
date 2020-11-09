//
//  ThemeRowView.swift
//  Memorize
//
//  Created by theswiftkid on 11/6/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

struct ThemeRowView: View {
    @EnvironmentObject var store: EmojiThemeStore

    private(set) var theme: EmojiTheme
    @State var themeName: String = ""
    @State var emojis: [String] = []

    @Binding var editMode: EditMode

    @State var showThemeEditor: Bool = false

    var body: some View {
        Group {
            if (editMode.isEditing) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Edit " + themeName)
                        .foregroundColor(.blue)
                    Text(emojis.joined())
                }
                .onTapGesture {
                    showThemeEditor = true
                }
                .sheet(isPresented: $showThemeEditor, onDismiss: {
                    let updatedTheme = store.findTheme(theme)!
                    themeName = updatedTheme.name
                    emojis = updatedTheme.emojis
                }) {
                    EmojiThemeEditor(theme: theme, isShowing: $showThemeEditor)
                        .environmentObject(store)
                }
            } else {
                VStack(alignment: .leading, spacing: 10) {
                    Text(themeName)
                    Text(emojis.joined())
                }
            }
        }.onAppear {
            themeName = theme.name
            emojis = theme.emojis
        }
    }
}
