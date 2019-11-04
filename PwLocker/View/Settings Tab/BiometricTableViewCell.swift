//
//  BiometricTableViewCell.swift
//  PwLocker
//
//  Created by Tavares on 02/11/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit

class BiometricTableViewCell: UITableViewCell, BEMCheckBoxDelegate {

    @IBOutlet weak var biometricBox: BEMCheckBox!
    @IBOutlet weak var biometricLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        biometricBox.delegate = self
        detectActivateButtonChoosen()
    }
    
    @objc func detectActivateButtonChoosen() {
        let loginPageOption = UserDefaults.standard.object(forKey: "LoginPage") as? String
        
        if loginPageOption == "StoryB" {
            biometricBox.on = true
        } else {
            biometricBox.on = false
        }
    }
}
