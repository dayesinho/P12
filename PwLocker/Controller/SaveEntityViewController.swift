//
//  SaveEntityViewController.swift
//  PwLocker
//
//  Created by Tavares on 29/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import KeychainSwift

struct Keys {
    
    static let forEmail = "forEmail"
    static let forLogin = "forLogin"
    static let forPassword = "forPassword"
    static let forWebsite = "forWebsite"
    static let forName = "forName"
}

class SaveEntityViewController: UIViewController {
    
    let keychain = KeychainSwift()
    var dataGroups = [Keys]()
 
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        guard let emailAddress = emailAddressTextField.text else { return }
        guard let login = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let website = websiteTextField.text else { return }
        guard let name = nameTextField.text else { return }
        
        keychain.set(emailAddress, forKey: Keys.forEmail, withAccess: KeychainSwiftAccessOptions.accessibleWhenPasscodeSetThisDeviceOnly)
        keychain.set(login, forKey: Keys.forLogin, withAccess: KeychainSwiftAccessOptions.accessibleWhenPasscodeSetThisDeviceOnly)
        keychain.set(password, forKey: Keys.forPassword, withAccess: KeychainSwiftAccessOptions.accessibleWhenPasscodeSetThisDeviceOnly)
        keychain.set(website, forKey: Keys.forWebsite, withAccess: KeychainSwiftAccessOptions.accessibleAlways)
        keychain.set(name, forKey: Keys.forName, withAccess: KeychainSwiftAccessOptions.accessibleAlways)
        
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
