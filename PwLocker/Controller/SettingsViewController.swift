//
//  SettingsViewController.swift
//  PwLocker
//
//  Created by Tavares on 26/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import KeychainSwift

class SettingsViewController: UIViewController {
    
    let keychain = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func deleteAllDataKeychain() {
        keychain.clear()
    }
}
