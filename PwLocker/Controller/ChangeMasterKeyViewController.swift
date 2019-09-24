//
//  ChangeMasterKeyViewController.swift
//  PwLocker
//
//  Created by Tavares on 25/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit

class ChangeMasterKeyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var originalMasterKeyTextField: UITextField!
    @IBOutlet weak var newMasterKeyTextField: UITextField!
    @IBOutlet weak var confirmNewMasterKeyTextField: UITextField!
    
    @IBAction func changeMasterKeyBUtton(_ sender: UIButton) {
        
        var originalMasterKey = UserDefaults.standard.object(forKey: "loginPass") as? String
        let newMasterKey = newMasterKeyTextField.text
        let confirmMasterKey = confirmNewMasterKeyTextField.text
        
        if originalMasterKey != originalMasterKeyTextField.text {
            showAlert(title: "Error", message: "You entered the wrong Master Key")
        } else if newMasterKey != confirmMasterKey {
             showAlert(title: "Error", message: "You have not entered the same passwords")
        } else if newMasterKey == nil && confirmMasterKey == nil {
            showAlert(title: "Error", message: "The fields are blank")
        } else {
            originalMasterKey = newMasterKey
            UserDefaults.standard.set(originalMasterKey, forKey: "loginPass")
            _ = navigationController?.popViewController(animated: true)
        }
    }
}
