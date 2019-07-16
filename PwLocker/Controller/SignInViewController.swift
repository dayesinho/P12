//
//  SignInViewController.swift
//  PwLocker
//
//  Created by Tavares on 14/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var emailAddressTextField: UITextField! {
        didSet {
            emailAddressTextField.tintColor = UIColor.lightGray
            emailAddressTextField.setIcon(#imageLiteral(resourceName: "email"))
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.tintColor = UIColor.lightGray
            passwordTextField.setIcon(#imageLiteral(resourceName: "key"))
        }
    }
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var noAccountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showEmailSaved()
    }
    
    @IBAction func signInButton(_ sender: Any) {
        
        guard let email = emailAddressTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let _ = user {
                self.performSegue(withIdentifier: "HomePageSegue", sender: self)
            } else {
                // Show errors:
                print("wrong password")
            }
        }
    }
    
    @IBAction func forgotPasswordButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "RegisterSegue", sender: self)
    }
    
    func showEmailSaved() {
        let email = UserDefaults.standard.object(forKey: "clientEmail")
        if email == nil {
            emailAddressTextField.text = email as? String
        } else {
            emailAddressTextField.text = email as? String
            emailAddressTextField.isUserInteractionEnabled = false
            registerButton.alpha = 0
            noAccountLabel.alpha = 0
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
