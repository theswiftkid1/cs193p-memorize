//
//  Data+utf8.swift
//  Memorize
//
//  Created by theswiftkid_ on 10/19/20.
//  Copyright © 2020 theswiftkid_. All rights reserved.
//

import Foundation

extension Data {
    var utf8: String? { String(data: self, encoding: .utf8 ) }
}
