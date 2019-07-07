//
//  ActivityIndicator.swift
//  PwLocker
//
//  Created by Tavares on 06/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func toggleActivityIndicator(loadingLabel: UILabel, activityIndicator: UIActivityIndicatorView, shown: Bool) {
         DispatchQueue.main.async {
        loadingLabel.isHidden = !shown
        activityIndicator.isHidden = !shown
        }
    }
}
