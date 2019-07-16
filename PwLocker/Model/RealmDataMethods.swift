//
//  Methods.swift
//  PwLocker
//
//  Created by Tavares on 15/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDataMethods {
    let realm = try! Realm()
    
    public func write(_ block: (() throws -> Void)) throws {
        realm.beginWrite()
        do {
            try block()
        } catch let error {
            if realm.isInWriteTransaction { realm.cancelWrite() }
            throw error
        }
        if realm.isInWriteTransaction { try realm.commitWrite() }
    }
}

