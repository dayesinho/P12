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
    @IBOutlet weak var connectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectButton.tag = 1
        setLabelMenu()
    }
    
    fileprivate func setLabelMenu() {
        let loginPass = UserDefaults.standard.object(forKey: "loginPass") as? String
        
        if loginPass == nil {
            situationLabel.text = "Create your Master Key"
            connectButton.setTitle("Create", for: UIControl.State.normal)
        } else {
            situationLabel.text = "Enter your Master Key"
        }
    }
    
    func accountAlreadyCreated() {
        
        let loginPass = UserDefaults.standard.object(forKey: "loginPass") as? String
        
        situationLabel.text = "Enter your Master Key"
        if displayTextField.text == loginPass {
            connectButton.tag = 2
            performSegue(withIdentifier: "HomePageSegue", sender: self)
        } else {
            showAlert(title: "Error", message: "Incorrect password")
        }
    }
    
     func createPassword() {
        if displayTextField.text == "" {
            showAlert(title: "Error", message: "You need to insert a password")
        } else {
            situationLabel.text = "Confirm Password"
            connectButton.setTitle("Confirm", for: UIControl.State.normal)
            password1 = displayTextField.text
            displayTextField.text = ""
        }
    }
    
     func passwordConfimed() {
        if displayTextField.text == "" {
            showAlert(title: "Error", message: "Confirmation password is required")
        } else {
            password2 = displayTextField.text
        }
        if password1 == password2 {
            officalPassword = password1
            UserDefaults.standard.set(officalPassword, forKey: "loginPass")
            displayTextField.text = ""
        } else {
           showAlert(title: "Error", message: "The passwords are not the same")
        }
    }
    
    @IBAction func connectButtonTapped(_ sender: Any) {
        
        let loginPass = UserDefaults.standard.object(forKey: "loginPass") as? String
        
        if loginPass != nil {
             accountAlreadyCreated()
        } else {
            if connectButton.tag == 1 {
                createPassword()
                connectButton.tag = 2
            } else if connectButton.tag == 2 {
                passwordConfimed()
                performSegue(withIdentifier: "HomePageSegue", sender: self)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
