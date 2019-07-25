//
//  WebsiteObject.swift
//  PwLocker
//
//  Created by Tavares on 09/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import Foundation
import RealmSwift

class WebsiteObject: Object {
    
    @objc dynamic var emailAddress = ""
    @objc dynamic var login = ""
    @objc dynamic var password = ""
    @objc dynamic var website = ""
    @objc dynamic var name = ""
}
