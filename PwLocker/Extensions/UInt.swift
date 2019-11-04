//
//  UInt.swift
//  PwLocker
//
//  Created by Tavares on 27/10/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import Foundation

extension UInt {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}
