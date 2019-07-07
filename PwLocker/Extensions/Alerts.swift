//
//  Alerts.swift
//  PwLocker
//
//  Created by Tavares on 01/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true)
    }
}
