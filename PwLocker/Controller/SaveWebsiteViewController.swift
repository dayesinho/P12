//
//  SaveEntityViewController.swift
//  PwLocker
//
//  Created by Tavares on 29/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import RealmSwift

class SaveWebsiteViewController: UIViewController {
    
    let websiteObject = WebsiteObject()
    let realm = try? Realm()
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        websiteObject.emailAddress = emailAddressTextField.text
        websiteObject.login = loginTextField.text
        websiteObject.password = passwordTextField.text
        websiteObject.website = websiteTextField.text
        websiteObject.name = nameTextField.text?.firstUppercased
        
        try? realm?.write {
            realm?.add(websiteObject)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
