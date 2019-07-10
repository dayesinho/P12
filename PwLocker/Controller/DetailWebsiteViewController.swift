//
//  DetailsViewController.swift
//  PwLocker
//
//  Created by Tavares on 27/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import RealmSwift

class DetailWebsiteViewController: UIViewController {
    
    let realm = try? Realm()
    var websiteObject: WebsiteObject?
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showWebsiteDetails()
    }

    fileprivate func showWebsiteDetails() {
        
        emailAddressTextField.text = websiteObject?.emailAddress
        loginTextField.text = websiteObject?.login
        passwordTextField.text = websiteObject?.password
        websiteTextField.text = websiteObject?.website
        nameTextfield.text = websiteObject?.name
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        
//        emailAddressTextField.backgroundColor = UIColor.white
//        loginTextField.backgroundColor = UIColor.white
//        passwordTextField.backgroundColor = UIColor.white
//        websiteTextField.backgroundColor = UIColor.white
//        nameTextfield.backgroundColor = UIColor.white
        
        emailAddressTextField.isUserInteractionEnabled = true
        loginTextField.isUserInteractionEnabled = true
        passwordTextField.isUserInteractionEnabled = true
        websiteTextField.isUserInteractionEnabled = true
        nameTextfield.isUserInteractionEnabled = true
        
        saveButton.alpha = 1
        cancelButton.alpha = 1
        editButton.isEnabled = false
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        if let websiteObject = websiteObject {
            do {
                try self.realm?.write {
                websiteObject.emailAddress = emailAddressTextField.text
//                _ = realm?.objects(WebsiteObject.self)
                }
            }
            catch {
                print("Error")
            }
        }
        websiteObject?.emailAddress = emailAddressTextField.text
        websiteObject?.login = loginTextField.text
        websiteObject?.password = passwordTextField.text
        websiteObject?.website = websiteTextField.text
        websiteObject?.name = nameTextfield.text

//        try? realm?.write {
//            realm?.add(websiteObject!)
//        }
        
        saveButton.alpha = 0
        cancelButton.alpha = 0
        editButton.isEnabled = true
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        emailAddressTextField.isUserInteractionEnabled = false
        loginTextField.isUserInteractionEnabled = false
        passwordTextField.isUserInteractionEnabled = false
        websiteTextField.isUserInteractionEnabled = false
        nameTextfield.isUserInteractionEnabled = false
        saveButton.alpha = 0
        cancelButton.alpha = 0
        editButton.isEnabled = true
    }
    
}
