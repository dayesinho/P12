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
    
    @objc dynamic var emailAddress: String?
    @objc dynamic var login: String?
    @objc dynamic var password: String?
    @objc dynamic var website: String?
    @objc dynamic var name: String?
}
