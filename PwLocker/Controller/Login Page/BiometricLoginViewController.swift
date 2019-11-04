//
//  BiometricLoginViewController.swift
//  PwLocker
//
//  Created by Tavares on 04/11/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import LocalAuthentication

class BiometricLoginViewController: UIViewController {

    let context = LAContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        biometricAuthentication()
    }
    
    fileprivate func biometricAuthentication() {
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy( .deviceOwnerAuthenticationWithBiometrics, localizedReason: "To go further, we need to check your identity") { (wasSuccessful, error) in
                DispatchQueue.main.async {
                    if wasSuccessful {
                        self.performSegue(withIdentifier: "HomePageSegue", sender: self)
                    } else {
                        self.showAlert(title: "Authentication failed", message: "Try again or enter your Master Key")
                    }
                }
            }
        } else {
            self.showAlert(title: "FaceID/TouchID not configured", message: "Please, go on the settings of your iPhone to set up Face ID/Touch ID ")
        }
    }
}
