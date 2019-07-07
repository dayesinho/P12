//
//  DetailsViewController.swift
//  PwLocker
//
//  Created by Tavares on 27/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import KeychainSwift

class DetailsViewController: UIViewController {
    
    let keychain = KeychainSwift()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromKeychain()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getDataFromKeychain()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDataFromKeychain()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    
    func getDataFromKeychain() {
        
        guard let emailAddressData = keychain.getData(Keys.forEmail) else { return }
        guard let loginData = keychain.getData(Keys.forLogin) else { return }
        guard let passwordData = keychain.getData(Keys.forPassword) else { return }
        guard let websiteData = keychain.getData(Keys.forWebsite) else { return }
        guard let nameData = keychain.getData(Keys.forName) else { return }
        
        let emailAddress = String(decoding: emailAddressData, as: UTF8.self)
        let login = String(decoding: loginData, as: UTF8.self)
        let password = String(decoding: passwordData, as: UTF8.self)
        let website = String(decoding: websiteData, as: UTF8.self)
        let name = String(decoding: nameData, as: UTF8.self)
        
        emailAddressTextField.text = emailAddress
        loginTextField.text = login
        passwordTextField.text = password
        websiteTextField.text = website
        nameTextfield.text = name
    }
}
