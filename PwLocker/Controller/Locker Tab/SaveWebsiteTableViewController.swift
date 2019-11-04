//
//  SaveWebsiteTableViewController.swift
//  PwLocker
//
//  Created by Tavares on 15/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import RealmSwift
import Navajo_Swift

class SaveWebsiteTableViewController: UITableViewController {

    let websiteObject = WebsiteObject()
    let realmEncryption = Encryption()
    
    @IBOutlet var saveWebsiteTableView: UITableView!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var strengthPasswordTextField: UITextField!
    @IBOutlet weak var showHideButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveWebsiteTableView.tableFooterView = UIView()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        saveWebsiteTableView.reloadData()
        navigationItem.largeTitleDisplayMode = .always
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        realmEncryption.saveWebsiteEncrypted(email: emailAddressTextField, login: loginTextField, password: passwordTextField, website: websiteTextField, name: nameTextField)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
          dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showHidePasswordButton(_ sender: Any) {
        
        if showHideButton.isSelected == false {
            showHideButton.isSelected = true
            passwordTextField.isSecureTextEntry = false
            showHideButton.setImage(UIImage(named : "eyeHide"), for: .selected)
        } else {
            showHideButton.isSelected = false
            passwordTextField.isSecureTextEntry = true
            showHideButton.setImage(UIImage(named : "eye"), for: .normal)
        }
    }
    
    @IBAction func textFieldEditingDidChanged(_ sender: Any) {
        
        if passwordTextField.hasText == true {
            showHideButton.isHidden = false
        } else {
            showHideButton.isHidden = true
        }
        
        let password = passwordTextField.text ?? ""
        let strength = Navajo.strength(ofPassword: password)
        
        if password == "" {
            strengthPasswordTextField.text = ""
        } else {
            strengthPasswordTextField.text = Navajo.localizedString(forStrength: strength)
            changeStrengthColors()
        }
    }
    
    func changeStrengthColors() {
        
        let password = passwordTextField.text ?? ""
        let strength = Navajo.strength(ofPassword: password)
        switch strength {
        case .veryWeak:
            strengthPasswordTextField.textColor = UIColor.red
        case .weak:
            strengthPasswordTextField.textColor = UIColor(red: 255/255.0, green: 38/255.0, blue: 0/255.0, alpha: 1)
        case .reasonable:
            strengthPasswordTextField.textColor = UIColor(red: 255/255.0, green: 147/255.0, blue: 0/255.0, alpha: 1)
        case .strong:
            strengthPasswordTextField.textColor = UIColor(red: 142/255.0, green: 250/255.0, blue: 0/255.0, alpha: 1)
        case .veryStrong:
            strengthPasswordTextField.textColor = UIColor.green
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
