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
            }
        }
    }
}

//struct ThemeEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeEditor()
//    }
//}
