//
//  Array.swift
//  PwLocker
//
//  Created by Tavares on 07/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    func indexes(ofItemsNotEqualTo item: Element) -> [Int]  {
        return enumerated().compactMap { $0.element != item ? $0.offset : nil }
    }
}
