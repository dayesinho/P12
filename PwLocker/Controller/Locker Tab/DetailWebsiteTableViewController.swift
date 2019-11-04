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
    
    let realmEncryption = Encryption()
    var websiteObject: WebsiteObject?
    var iconIsTapped = false
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
    @IBOutlet weak var showHideButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = websiteObject?.name
        detailWebsiteTableView.tableFooterView = UIView()
        deleteButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        showWebsiteObject()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewWillAppear(_ animated: Bool) {
        detailWebsiteTableView.reloadData()
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
        
        showDeleteAlert(title: "Warning", message: "Are you sure that you want delete these information?")
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
        
        guard let browserPrefix = UserDefaults.standard.object(forKey: "BrowserPrefix") as? String else { return }
        
        guard let urlForSafari = websiteTextField.text else { return }
        let validUrlString = urlForSafari.hasPrefix("http") ? urlForSafari : browserPrefix + urlForSafari
         guard let url = URL(string: validUrlString) else { return }
        UIApplication.shared.open(url)
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
    
    @IBAction func textFiedEditingDidChange(_ sender: Any) {
        
        if passwordTextField.text == "" {
            showHideButton.isHidden = true
        } else {
            showHideButton.isHidden = false
        }
            
        let password = passwordTextField.text ?? ""
        let strength = Navajo.strength(ofPassword: password)
        
        if password == "" {
            passwordStrengthTextField.text = ""
        } else {
            passwordStrengthTextField.text = Navajo.localizedString(forStrength: strength)
            changeStrengthColors()
        }
    }
    
    func showDeleteAlert(title: String, message: String) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertVC.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: { (action) in
            alertVC.dismiss(animated: true, completion: nil)
            autoreleasepool {
                guard let unwrappedWebsiteObject = self.websiteObject else { return }
                
                let configuration = Realm.Configuration(encryptionKey: getKey() as Data)
                let realm = try? Realm(configuration: configuration)
                try? realm?.write {
                    realm?.delete(unwrappedWebsiteObject)
                }
                self.performSegue(withIdentifier: "backHomePage", sender: self)
            }
        }))
        
        alertVC.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: { (action) in
            alertVC.dismiss(animated: true, completion: nil) }))
        
        self.present(alertVC, animated: true, completion: nil)
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
            changeStrengthColors()
        }
    }
    
    func changeStrengthColors() {
        
        let password = passwordTextField.text ?? ""
        let strength = Navajo.strength(ofPassword: password)
        switch strength {
        case .veryWeak:
            passwordStrengthTextField.textColor = UIColor.red
        case .weak:
            passwordStrengthTextField.textColor = UIColor(red: 255/255.0, green: 38/255.0, blue: 0/255.0, alpha: 1)
        case .reasonable:
            passwordStrengthTextField.textColor = UIColor(red: 255/255.0, green: 147/255.0, blue: 0/255.0, alpha: 1)
        case .strong:
            passwordStrengthTextField.textColor = UIColor(red: 142/255.0, green: 250/255.0, blue: 0/255.0, alpha: 1)
        case .veryStrong:
            passwordStrengthTextField.textColor = UIColor.green
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
