//
//  PasswordRegex.swift
//  PwLocker
//
//  Created by Tavares on 24/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import Foundation

public func isValidPassword(password: String) -> Bool {
    let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
    return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
}
