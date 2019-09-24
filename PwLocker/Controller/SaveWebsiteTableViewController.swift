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
    let realmEncryption = RealmEncryption()
    
    @IBOutlet var saveWebsiteTableView: UITableView!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var strengthPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveWebsiteTableView.tableFooterView = UIView()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        showPasswordStrength()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showPasswordStrength()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showPasswordStrength()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        realmEncryption.saveWebsiteEncrypted(email: emailAddressTextField, login: loginTextField, password: passwordTextField, website: websiteTextField, name: nameTextField)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
          dismiss(animated: true, completion: nil)
    }
    
    func showPasswordStrength() {
        
        let password = passwordTextField.text ?? ""
        let strength = Navajo.strength(ofPassword: password)
        
        if password == "" {
            strengthPasswordTextField.text = ""
        } else {
            strengthPasswordTextField.text = Navajo.localizedString(forStrength: strength)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
