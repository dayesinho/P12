////
////  PasswordRegex.swift
////  PwLocker
////
////  Created by Tavares on 11/07/2019.
////  Copyright © 2019 Tavares. All rights reserved.
////
//
//import Foundation
//
//enum PasswordStrength: Int {
//    case None
//    case Weak
//    case Moderate
//    case Strong
//    
//    static func checkStrength(password: String) -> PasswordStrength {
//        var len: Int = countElements(password)
//        var strength: Int = 0
//        
//        switch len {
//        case 0:
//            return .None
//        case 1...4:
//            strength++
//        case 5...8:
//            strength += 2
//        default:
//            strength += 3
//        }
//        
//        // Upper case, Lower case, Number & Symbols
//        let patterns = ["^(?=.*[A-Z]).*$", "^(?=.*[a-z]).*$", "^(?=.*[0-9]).*$", "^(?=.*[!@#%&-_=:;\"'<>,`~\\*\\?\\+\\[\\]\\(\\)\\{\\}\\^\\$\\|\\\\\\.\\/]).*$"]
//        
//        for pattern in patterns {
//            if (password =~ pattern).boolValue {
//                strength++
//            }
//        }
//        
//        switch strength {
//        case 0:
//            return .None
//        case 1...3:
//            return .Weak
//        case 4...6:
//            return .Moderate
//        default:
//            return .Strong
//        }
//    }
//}
