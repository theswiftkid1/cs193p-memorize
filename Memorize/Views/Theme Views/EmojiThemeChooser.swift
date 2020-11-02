//
//  EmojiThemeChooser.swift
//  Memorize
//
//  Created by theswiftkid_ on 10/24/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

struct EmojiThemeChooser: View {
    @EnvironmentObject private var store: EmojiThemeStore

    @State private var editMode: EditMode = .inactive
    @State private var showThemeEditor: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink(
                        destination:
                            EmojiGameView(game: EmojiGame(theme: theme))
                                .navigationBarTitle(theme.name + "!")
                    ) {
                        ThemeRowView(
                            theme: theme,
                            showThemeEditor: $showThemeEditor,
                            editMode: $editMode
                        )
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { store.themes[$0] }.forEach { theme in
                        store.removeTheme(theme)
                    }
                }
            }
            .navigationBarTitle(Text("Themes Store"))
            .navigationBarItems(
                leading: Button {
                    store.addUntitledTheme()
                } label: {
                    Image(systemName: "plus").imageScale(.large)
                },
                trailing: EditButton()
            )
            .environment(\.editMode, $editMode)
        }
    }
}

struct ThemeRowView: View {
    @State var theme: EmojiTheme
    @Binding var showThemeEditor: Bool
    @Binding var editMode: EditMode

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if (editMode.isEditing) {
                Text("Edit " + theme.name)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        showThemeEditor = true
                    }
                    .popover(isPresented: $showThemeEditor) {
                        EmojiThemeEditor(theme: $theme, isShowing: $showThemeEditor)
                    }
            } else {
                Text(theme.name)
            }
            Text(theme.emojis.joined())
        }
    }
}

struct EmojiThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        EmojiThemeChooser()
    }
}
