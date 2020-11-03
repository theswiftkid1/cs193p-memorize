//
//  EmojiThemeChooser.swift
//  Memorize
//
//  Created by theswiftkid_ on 10/24/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var store: EmojiThemeStore
    
    @State private var editMode: EditMode = .inactive
    @State private var showThemeEditor: Bool = false
    @State private var themeToEdit: EmojiTheme = EmojiTheme.defaultTheme
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink(
                        destination:
                            EmojiGameView(game: EmojiGame(theme: theme))
                    ) {
                        ThemeRowView(
                            theme: theme,
                            themeToEdit: $themeToEdit,
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
            .navigationBarTitle(Text("Home"))
            .navigationBarItems(
                leading: Button {
                    store.addUntitledTheme()
                } label: {
                    Image(systemName: "plus").imageScale(.large)
                },
                trailing: EditButton()
            )
            .environment(\.editMode, $editMode)
            .popover(isPresented: $showThemeEditor) {
                EmojiThemeEditor(theme: $themeToEdit, isShowing: $showThemeEditor)
            }
        }
    }
}

struct ThemeRowView: View {
    var theme: EmojiTheme
    @Binding var themeToEdit: EmojiTheme
    @Binding var showThemeEditor: Bool
    @Binding var editMode: EditMode
    
    var body: some View {
        if (editMode.isEditing) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Edit " + theme.name)
                    .foregroundColor(.blue)
                Text(theme.emojis.joined())
            }
            .onTapGesture {
                showThemeEditor = true
                themeToEdit = theme
            }
        } else {
            VStack(alignment: .leading, spacing: 10) {
                Text(theme.name)
                Text(theme.emojis.joined())
            }
        }
    }
}

struct EmojiThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
