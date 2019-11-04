//
//  LoginViewController.swift
//  PwLocker
//
//  Created by Tavares on 17/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var password1: String?
    var password2: String?
    var officalPassword: String?
    
    @IBOutlet weak var situationLabel: UILabel!
    @IBOutlet weak var displayTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelMenu()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        situationLabel.isHidden = false
        displayTextField.isHidden = false
        displayTextField.becomeFirstResponder()
    }
    
    fileprivate func setLabelMenu() {
//        displayTextField.becomeFirstResponder()
        let loginPass = UserDefaults.standard.object(forKey: "loginPass") as? String
        
        if loginPass == nil {
            situationLabel.text = "Create your Master Key"
        } else {
            situationLabel.text = "Enter your Master Key"
        }
    }
    
    fileprivate func accountAlreadyCreated() {
        
        let loginPass = UserDefaults.standard.object(forKey: "loginPass") as? String
        
        situationLabel.text = "Enter your Master Key"
        if displayTextField.text == loginPass {
            performSegue(withIdentifier: "HomePageSegue", sender: self)
        } else {
            showAlert(title: "Error", message: "Incorrect password")
            displayTextField.resignFirstResponder()
        }
    }
    
    fileprivate func createPassword() {
        if displayTextField.text == "" {
            showAlert(title: "Error", message: "You need to insert a password")
            displayTextField.resignFirstResponder()
        } else {
            situationLabel.text = "Confirm Master Key"
            password1 = displayTextField.text
            displayTextField.text = ""
        }
    }
    
    fileprivate func passwordConfimed() {
        if displayTextField.text == "" {
            showAlert(title: "Error", message: "Confirmation password is required")
            displayTextField.resignFirstResponder()
        } else {
            password2 = displayTextField.text
        }
        if password1 == password2 {
            officalPassword = password1
            UserDefaults.standard.set(officalPassword, forKey: "loginPass")
            displayTextField.text = ""
        } else {
           showAlert(title: "Error", message: "The passwords are not the same")
            setLabelMenu()
            displayTextField.resignFirstResponder()
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let loginPass = UserDefaults.standard.object(forKey: "loginPass") as? String
        
        if loginPass != nil {
            accountAlreadyCreated()
        } else {
            if situationLabel.text == "Create your Master Key" {
                createPassword()
            } else if situationLabel.text == "Confirm Master Key" {
                passwordConfimed()
                performSegue(withIdentifier: "HomePageSegue", sender: self)
                return true
            }
        }
        return true
    }
}

