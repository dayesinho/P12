//////
//////  RealmEncryption.swift
//////  PwLocker
//////
//////  Created by Tavares on 18/07/2019.
//////  Copyright © 2019 Tavares. All rights reserved.
//////
//
//import Foundation
//import RealmSwift
//
//class EncryptionService {
//    
//    func saveEncryptedData(email: UITextField, login: UITextField, password: UITextField, website: UITextField, name: UITextField) {
//        
//        autoreleasepool {
//            let configuration = Realm.Configuration(encryptionKey: getKey() as Data)
//            let realm = try! Realm(configuration: configuration)
//            
//            // Add an object
//            try! realm.write {
//                let websiteObject = WebsiteObject()
//                websiteObject.emailAddress = email.text ?? ""
//                websiteObject.login = login.text ?? ""
//                websiteObject.password = password.text ?? ""
//                websiteObject.website = website.text ?? ""
//                websiteObject.name = name.text ?? ""
//                
//                realm.add(websiteObject)
//            }
//        }
//        checkKeyValidity()
//    }
//    
//    func saveModificationsEncrypted(email: UITextField, password: UITextField) {
//        
//        autoreleasepool {
//            
//            let configuration = Realm.Configuration(encryptionKey: getKey() as Data)
//            let realm = try! Realm(configuration: configuration)
//            try? realm.write {
//                let firstObject = realm.objects(Website.self)
//                let websiteObject = firstObject[0]
//                websiteObject.emailAddress = email.text ?? ""
//                websiteObject.password = password.text ?? ""
//            }
//        }
//        checkKeyValidity()
//    }
//    
//    // Reopening with the correct key works and can read the data
//    
//    func pushDataEncrypted(email: UITextField, password: UITextField) {
//        autoreleasepool {
//            let configuration = Realm.Configuration(encryptionKey: getKey() as Data)
//            let realm = try! Realm(configuration: configuration)
//            let firstObject = realm.objects(Website.self)
//            let websiteObject = firstObject[0]
//            email.text = websiteObject.emailAddress
//            password.text = websiteObject.password
//        }
//        checkKeyValidity()
//    }
//    
//    fileprivate func checkKeyValidity() {
//        
//        // Opening with wrong key fails since it decrypts to the wrong thing
//        autoreleasepool {
//            do {
//                let configuration = Realm.Configuration(encryptionKey: "1234567890123456789012345678901234567890123456789012345678901234".data(using: String.Encoding.utf8, allowLossyConversion: false))
//                _ = try Realm(configuration: configuration)
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//        
//        // Opening wihout supplying a key at all fails
//        autoreleasepool {
//            do {
//                _ = try Realm()
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
//}
//
//func getKey() -> NSData {
//    
//    // Identifier for our keychain entry - should be unique for your application
//    let keychainIdentifier = "passlockerEncryptionDatabase"
//    let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
//    
//    // First check in the keychain for an existing key
//    var query: [NSString: AnyObject] = [
//        kSecClass: kSecClassKey,
//        kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
//        kSecAttrKeySizeInBits: 512 as AnyObject,
//        kSecReturnData: true as AnyObject
//    ]
//    
//    // To avoid Swift optimization bug, should use withUnsafeMutablePointer() function to retrieve the keychain item
//    
//    var dataTypeRef: AnyObject?
//    var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
//    if status == errSecSuccess {
//        return dataTypeRef as! NSData
//    }
//    
//    // No pre-existing key from this application, so generate a new one
//    let keyData = NSMutableData(length: 64)!
//    let result = SecRandomCopyBytes(kSecRandomDefault, 64, keyData.mutableBytes.bindMemory(to: UInt8.self, capacity: 64))
//    assert(result == 0, "Failed to get random bytes")
//    
//    // Store the key in the keychain
//    query = [
//        kSecClass: kSecClassKey,
//        kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
//        kSecAttrKeySizeInBits: 512 as AnyObject,
//        kSecValueData: keyData
//    ]
//    
//    status = SecItemAdd(query as CFDictionary, nil)
//    assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
//    print(keyData)
//    return keyData
//}
