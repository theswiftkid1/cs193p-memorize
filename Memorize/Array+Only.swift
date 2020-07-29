//
//  Array+Only.swift
//  Memorize
//
//  Created by theswiftkid_ on 7/29/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import Foundation

extension Array {    
    var only: Element? {
        count == 1 ? first : nil
    }
}
