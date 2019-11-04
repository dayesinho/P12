//
//  ChangeMasterKeyTableViewController.swift
//  PwLocker
//
//  Created by Tavares on 02/11/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import Navajo_Swift

class ChangeMasterKeyTableViewController: UITableViewController {

    @IBOutlet var changeMasterKeyTableView: UITableView!
    @IBOutlet weak var originalMasterKeyTextField: UITextField! {
        didSet {
            originalMasterKeyTextField.tintColor = UIColor.lightGray
            originalMasterKeyTextField.setIcon(#imageLiteral(resourceName: "key"))
        }
    }
    @IBOutlet weak var newMasterKeyTextField: UITextField! {
        didSet {
            newMasterKeyTextField.tintColor = UIColor.lightGray
            newMasterKeyTextField.setIcon(#imageLiteral(resourceName: "key"))
        }
    }
    @IBOutlet weak var confirmMasterKeyTextField: UITextField! {
        didSet {
            confirmMasterKeyTextField.tintColor = UIColor.lightGray
            confirmMasterKeyTextField.setIcon(#imageLiteral(resourceName: "key"))
        }
    }
    @IBOutlet weak var firstShowHidePasswordButton: UIButton!
    @IBOutlet weak var secondShowHidePasswordButton: UIButton!
    @IBOutlet weak var thirdShowHidePasswordButton: UIButton!
    @IBOutlet var backgroundUIView: [UIView]!
    @IBOutlet weak var strengthMasterKeyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalMasterKeyTextField.becomeFirstResponder()
        changeMasterKeyTableView.tableFooterView = UIView()
        originalMasterKeyTextField.roundCorners(corners: [.topLeft, .bottomLeft], radius: 20.0)
        newMasterKeyTextField.roundCorners(corners: [.topLeft, .bottomLeft], radius: 20.0)
        confirmMasterKeyTextField.roundCorners(corners: [.topLeft, .bottomLeft], radius: 20.0)
        for background in backgroundUIView {
            background.roundCorners(corners: [.topRight, .bottomRight], radius: 20.0)
        }
    }
    
    @IBAction func originalMasterKeyEditingChanged(_ sender: Any) {
        
        if originalMasterKeyTextField.text == "" {
                        firstShowHidePasswordButton.isHidden = true
                    } else {
                        firstShowHidePasswordButton.isHidden = false
                    }
    }
    

    @IBAction func newMasterKeyEditingChanged(_ sender: Any) {
        
        if newMasterKeyTextField.text == "" {
            secondShowHidePasswordButton.isHidden = true
        } else {
            secondShowHidePasswordButton.isHidden = false
        }
        
        let password = newMasterKeyTextField.text ?? ""
        let strength = Navajo.strength(ofPassword: password)
        
        if password == "" {
            strengthMasterKeyTextField.text = ""
        } else {
            strengthMasterKeyTextField.text = Navajo.localizedString(forStrength: strength)
            changeStrengthColors()
        }
    }
    
    @IBAction func confirmMasterKeyEditingChanged(_ sender: Any) {
        
        if confirmMasterKeyTextField.text == "" {
            thirdShowHidePasswordButton.isHidden = true
        } else {
            thirdShowHidePasswordButton.isHidden = false
        }
    }
    
    @IBAction func firstShowHideButtonTapped(_ sender: Any) {
        if firstShowHidePasswordButton.isSelected == false {
            firstShowHidePasswordButton.isSelected = true
            originalMasterKeyTextField.isSecureTextEntry = false
            firstShowHidePasswordButton.setImage(UIImage(named : "eyeHide"), for: .selected)
        } else {
            firstShowHidePasswordButton.isSelected = false
            originalMasterKeyTextField.isSecureTextEntry = true
            firstShowHidePasswordButton.setImage(UIImage(named : "eye"), for: .normal)
        }
    }
    
    @IBAction func secondShowHideButtonTapped(_ sender: Any) {
        if secondShowHidePasswordButton.isSelected == false {
            secondShowHidePasswordButton.isSelected = true
            newMasterKeyTextField.isSecureTextEntry = false
            secondShowHidePasswordButton.setImage(UIImage(named : "eyeHide"), for: .selected)
        } else {
            secondShowHidePasswordButton.isSelected = false
            newMasterKeyTextField.isSecureTextEntry = true
            secondShowHidePasswordButton.setImage(UIImage(named : "eye"), for: .normal)
        }
    }
    
    @IBAction func thirdShowHideButtonTapped(_ sender: Any) {
        if thirdShowHidePasswordButton.isSelected == false {
            thirdShowHidePasswordButton.isSelected = true
            confirmMasterKeyTextField.isSecureTextEntry = false
            thirdShowHidePasswordButton.setImage(UIImage(named : "eyeHide"), for: .selected)
        } else {
            thirdShowHidePasswordButton.isSelected = false
            confirmMasterKeyTextField.isSecureTextEntry = true
            thirdShowHidePasswordButton.setImage(UIImage(named : "eye"), for: .normal)
        }
    }
    
    func changeStrengthColors() {
        
        let password = newMasterKeyTextField.text ?? ""
        let strength = Navajo.strength(ofPassword: password)
        switch strength {
        case .veryWeak:
            strengthMasterKeyTextField.textColor = UIColor.red
        case .weak:
            strengthMasterKeyTextField.textColor = UIColor(red: 255/255.0, green: 38/255.0, blue: 0/255.0, alpha: 1)
        case .reasonable:
            strengthMasterKeyTextField.textColor = UIColor(red: 255/255.0, green: 147/255.0, blue: 0/255.0, alpha: 1)
        case .strong:
            strengthMasterKeyTextField.textColor = UIColor(red: 142/255.0, green: 250/255.0, blue: 0/255.0, alpha: 1)
        case .veryStrong:
            strengthMasterKeyTextField.textColor = UIColor.green
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 6
    }
}

extension ChangeMasterKeyTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var originalMasterKey = UserDefaults.standard.object(forKey: "loginPass") as? String
                let newMasterKey = newMasterKeyTextField.text
                let confirmMasterKey = confirmMasterKeyTextField.text
        
                if originalMasterKey != originalMasterKeyTextField.text {
                    showAlert(title: "Error", message: "You entered the wrong Master Key")
                    originalMasterKeyTextField.resignFirstResponder()
                } else if newMasterKey != confirmMasterKey {
                     showAlert(title: "Error", message: "You have not entered the same passwords")
                    newMasterKeyTextField.resignFirstResponder()
                } else if newMasterKey == "" && confirmMasterKey == "" {
                    showAlert(title: "Error", message: "The fields are blank")
                    newMasterKeyTextField.resignFirstResponder()
                } else {
                    originalMasterKey = newMasterKey
                    UserDefaults.standard.set(originalMasterKey, forKey: "loginPass")
                    _ = navigationController?.popViewController(animated: true)
                    return true
                }
        return true
    }
}
