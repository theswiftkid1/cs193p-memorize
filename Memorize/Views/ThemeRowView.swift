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

    @ObservedObject var theme: EmojiTheme

    @Binding var editMode: EditMode

    @State var showThemeEditor: Bool = false

    var body: some View {
        if (editMode.isEditing) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Edit " + theme.name)
                    .foregroundColor(.blue)
                Text(theme.emojis.joined())
            }
            .onTapGesture {
                showThemeEditor = true
            }
            .sheet(isPresented: $showThemeEditor) {
                EmojiThemeEditor(theme: theme, isShowing: $showThemeEditor)
                    .environmentObject(store)
            }
        } else {
            VStack(alignment: .leading, spacing: 10) {
                Text(theme.name)
                Text(theme.emojis.joined())
            }
        }
    }
}
