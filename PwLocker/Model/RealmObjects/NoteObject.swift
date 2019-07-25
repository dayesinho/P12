//
//  NoteObject.swift
//  PwLocker
//
//  Created by Tavares on 09/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import Foundation
import RealmSwift

class NoteObject: Object {
    
    @objc dynamic var noteTitle = ""
    @objc dynamic var noteContent = ""
}
