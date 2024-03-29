//
//  PasswordController.swift
//  PwLocker
//
//  Created by Tavares on 27/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {
    
    let passwordService = PasswordService()
    let red = UIColor(red: 148/255.0, green: 32/255.0, blue: 41/255.0, alpha: 1)
    let green = UIColor(red: 51/255.0, green: 190/255.0, blue: 98/255.0, alpha: 1)
    let darkGray = UIColor(red: 85/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1)
    let customGray = UIColor(red: 40/255.0, green: 40/255.0, blue: 40/255.0, alpha: 1)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.roundCorners(corners: [.topLeft, .bottomLeft], radius: 50.0)
        searchButton.roundCorners(corners: [.topRight, .bottomRight], radius: 50.0)
        toggleActivityIndicator(loadingLabel: loadingLabel, activityIndicator: activityIndicator, shown: false)
        showHideButton.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        descriptionResultTextView.centerVertically()
    }
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.tintColor = UIColor.lightGray
            passwordTextField.setIcon(#imageLiteral(resourceName: "key"))
        }
    }
    @IBOutlet weak var passwordResultView: UIView!
    @IBOutlet weak var titleResultLabel: UILabel!
    @IBOutlet weak var descriptionResultTextView: UITextView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var showHideButton: UIButton!
    @IBOutlet weak var clearResultButton: UIButton!
    
    @IBAction func searchButton(_ sender: Any) {
        
        guard let password = passwordTextField.text else { return }
        
        toggleActivityIndicator(loadingLabel: loadingLabel, activityIndicator: activityIndicator, shown: true)
        passwordTextField.resignFirstResponder()
        
        _ = try? passwordService.search(password: password) { result in
            self.toggleActivityIndicator(loadingLabel: self.loadingLabel, activityIndicator: self.activityIndicator, shown: false)
            DispatchQueue.main.async {
                 self.showHideButton.isHidden = true
            }
            if let pwnedTimes = try? result() {
                if pwnedTimes > 0 {
                    self.pwnedPresentation(pwnedNumber: pwnedTimes)
                } else {
                    self.notPwnedPresentation()
                }
            } else {
                    self.showAlert(title: "Error", message: "Something went wrong")
            }
        }
    }
    
    @IBAction func showHideButtonTapped(_ sender: Any) {
        
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
    
    @IBAction func textFieldEditingDidChange(_ sender: Any) {
        if passwordTextField.hasText == true {
            showHideButton.isHidden = false
        } else {
            showHideButton.isHidden = true
        }
    }
    
    @IBAction func clearResultButtonTapped(_ sender: Any) {
        clearResultButton.isHidden = true
        passwordResultView.backgroundColor = customGray
        descriptionResultTextView.backgroundColor = customGray
        titleResultLabel.text = ""
        descriptionResultTextView.text = ""
    }
    
    fileprivate func disableSearchButton() {
        
        guard let password = passwordTextField.text else { return }
        
        if password.isEmpty {
            searchButton.isEnabled = false
            searchButton.backgroundColor = UIColor.darkGray
            searchButton.setTitleColor(UIColor.black, for: .disabled)
        } else {
            searchButton.isEnabled = true
            searchButton.backgroundColor = green
        }
    }
    
    fileprivate func pwnedPresentation(pwnedNumber: UInt) {
        DispatchQueue.main.async {
            self.clearResultButton.isHidden = false
            self.passwordResultView.backgroundColor = self.red
            self.descriptionResultTextView.backgroundColor = self.red
            self.titleResultLabel.text = "Pwned!"
            self.descriptionResultTextView.text = "This password has been seen \(pwnedNumber) times before. This password has previously appeared in a data breach and should never be used. If you've ever used it anywhere before, use our password generator and change it!"
            self.passwordTextField.text = ""
        }
    }
    
    fileprivate func notPwnedPresentation() {
        DispatchQueue.main.async {
            self.clearResultButton.isHidden = false
            self.passwordResultView.backgroundColor = self.green
            self.descriptionResultTextView.backgroundColor = self.green
            self.titleResultLabel.text = "No pwnage found!"
            self.descriptionResultTextView.text = "This password wasn't found in any of the Pwned Passwords lists. That doesn't necessarily mean it's a good password, merely that wasn't stolen in the past."
            self.passwordTextField.text = ""
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
