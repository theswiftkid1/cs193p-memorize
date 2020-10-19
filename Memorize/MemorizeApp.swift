//
//  MemorizeApp.swift
//  Memorize
//
//  Created by theswiftkid_ on 10/19/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = EmojiGameViewModel()
            GameView(gameModel: viewModel)
        }
    }
}
