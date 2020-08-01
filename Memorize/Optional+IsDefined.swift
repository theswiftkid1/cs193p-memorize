//
//  Optional+IsDefined.swift
//  Memorize
//
//  Created by theswiftkid_ on 8/1/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import Foundation

public extension Optional {

    var isNil: Bool {
        guard case Optional.none = self else {
            return false
        }
        return true
    }

    var isSome: Bool {
        return !self.isNil
    }
}
