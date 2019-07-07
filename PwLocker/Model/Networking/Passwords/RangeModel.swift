
//
//  RangeModel.swift
//  PwLocker
//
//  Created by Tavares on 02/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import Foundation

public final class RangeModel: CustomDebugStringConvertible {
    
    /// SHA1 hash suffix [5-40]
    public let suffix: String
    
    /// suffix's prevalence counts
    public let count: UInt
    
    public init(suffix: String, count: UInt) {
        self.suffix = suffix
        self.count = count
    }
    
    // MARK: CustomDebugStringConvertible
    
    public var debugDescription: String {
        return "<\(Swift.type(of: self)): \(self.suffix) [\(self.count)]>"
    }
}
