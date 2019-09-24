//
//  DetailWebsiteTableViewController.swift
//  PwLocker
//
//  Created by Tavares on 15/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import RealmSwift
import Navajo_Swift

class DetailWebsiteTableViewController: UITableViewController {
    
    let realmEncryption = RealmEncryption()
    var websiteObject: WebsiteObject?
    let customGray = UIColor(red: 40/255.0, green: 40/255.0, blue: 40/255.0, alpha: 1)
    
    @IBOutlet weak var headerCell: UITableViewCell!
    @IBOutlet weak var deleteCell: UITableViewCell!
    @IBOutlet weak var detailWebsiteTableView: UITableView!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordStrengthTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerCell.isHidden = true
        deleteCell.isHidden = true
        navigationItem.title = websiteObject?.name
        detailWebsiteTableView.tableFooterView = UIView()
        deleteButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        showWebsiteObject()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
        UIView.animate(withDuration: 0, delay: 0, options: [.allowUserInteraction], animations: {
            self.headerCell.alpha = 0
            self.deleteCell.alpha = 0
        }, completion: nil)
        
        headerCell.isHidden = false
        deleteCell.isHidden = false
        showWebsiteObject()
    }


    func toggleEditingMode(editing: Bool) {
        
        emailAddressTextField.isUserInteractionEnabled = editing
        loginTextField.isUserInteractionEnabled = editing
        passwordTextField.isUserInteractionEnabled = editing
        websiteTextField.isUserInteractionEnabled = editing
        nameTextField.isUserInteractionEnabled = editing
    }
    
    func toggleDifferentColor(background: UIColor, textColor: UIColor) {
        
        emailAddressTextField.backgroundColor = background
        loginTextField.backgroundColor = background
        passwordTextField.backgroundColor = background
        websiteTextField.backgroundColor = background
        nameTextField.backgroundColor = background
        
        emailAddressTextField.textColor = textColor
        loginTextField.textColor = textColor
        passwordTextField.textColor = textColor
        websiteTextField.textColor = textColor
        nameTextField.textColor = textColor
    }
    
    @objc func editTapped() {
        UIView.animate(withDuration: 1, animations: {
            self.emailAddressTextField.layer.backgroundColor = UIColor.darkGray.cgColor
            self.loginTextField.layer.backgroundColor = UIColor.darkGray.cgColor
            self.passwordTextField.layer.backgroundColor = UIColor.darkGray.cgColor
            self.websiteTextField.layer.backgroundColor = UIColor.darkGray.cgColor
            self.nameTextField.layer.backgroundColor = UIColor.darkGray.cgColor
        })
        
        UIView.animate(withDuration: 1, delay: 0, options: [.allowUserInteraction], animations: {
            self.headerCell.alpha = 1
             self.deleteCell.alpha = 1
            self.headerCell.isHidden = false
             self.deleteCell.isHidden = false
        }, completion: nil)
        
        toggleEditingMode(editing: true)
        toggleDifferentColor(background: UIColor.darkGray, textColor: UIColor.white)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTapped))
    }
    
    @objc func saveTapped() {
        
        UIView.animate(withDuration: 1, animations: {
            self.emailAddressTextField.layer.backgroundColor = self.customGray.cgColor
            self.loginTextField.layer.backgroundColor = self.customGray.cgColor
            self.passwordTextField.layer.backgroundColor = self.customGray.cgColor
            self.websiteTextField.layer.backgroundColor = self.customGray.cgColor
            self.nameTextField.layer.backgroundColor = self.customGray.cgColor
        })
        
        toggleEditingMode(editing: false)
        toggleDifferentColor(background: customGray, textColor: UIColor.white)

        realmEncryption.saveModificationsEncrypted(websiteObject: websiteObject, email: emailAddressTextField, login: loginTextField, password: passwordTextField, website: websiteTextField, name: nameTextField)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        UIView.animate(withDuration: 1, delay: 0, options: [.allowUserInteraction], animations: {
            self.headerCell.alpha = 0
            self.deleteCell.alpha = 0
        }, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        
        autoreleasepool {
            guard let unwrappedWebsiteObject = websiteObject else { return }
            
            let configuration = Realm.Configuration(encryptionKey: getKey() as Data)
            let realm = try? Realm(configuration: configuration)
            try? realm?.write {
                realm?.delete(unwrappedWebsiteObject)
            }
            performSegue(withIdentifier: "backHomePage", sender: self)
        }
    }
    
    @IBAction func copyEmailButtonTapped(_ sender: Any) {
        UIPasteboard.general.string = emailAddressTextField.text
    }
    
    @IBAction func copyLoginButtonTapped(_ sender: Any) {
        UIPasteboard.general.string = loginTextField.text
    }
    
    @IBAction func copyPasswordTapped(_ sender: Any) {
        UIPasteboard.general.string = passwordTextField.text
    }
    
    @IBAction func connectToWebsiteButtonTapped(_ sender: Any) {
        guard let urlForSafari = websiteTextField.text else { return }
        guard let url = URL(string: "https://www." + urlForSafari) else { return }
        UIApplication.shared.open(url)
    }
    
    func showWebsiteObject() {
        
        emailAddressTextField.text = websiteObject?.emailAddress
        loginTextField.text = websiteObject?.login
        passwordTextField.text = websiteObject?.password
        websiteTextField.text = websiteObject?.website
        nameTextField.text = websiteObject?.name
        
        let password = websiteObject?.password ?? ""
        let strength = Navajo.strength(ofPassword: password)
        
        if passwordTextField.text == "" {
            passwordStrengthTextField.text = ""
        } else {
            passwordStrengthTextField.text = Navajo.localizedString(forStrength: strength)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
