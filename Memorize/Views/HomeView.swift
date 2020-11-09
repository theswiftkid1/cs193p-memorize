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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink(
                        destination:
                            EmojiGameView(game: EmojiGame(theme: theme))
                            .navigationBarTitle(Text(theme.name))
                    ) {
                        ThemeRowView(
                            theme: theme,
                            editMode: $editMode
                        )
                        .environmentObject(store)
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { store.themes[$0] }.forEach { theme in
                        store.removeTheme(theme)
                    }
                }
            }
            .navigationBarTitle(Text("Memorize"))
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

struct EmojiThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
