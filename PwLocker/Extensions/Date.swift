//
//  Date.swift
//  PwLocker
//
//  Created by Tavares on 05/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import Foundation

extension Date {
    
    func asString(style: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
}
