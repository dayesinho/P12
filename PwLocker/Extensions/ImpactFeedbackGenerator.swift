//
//  ImpactFeedbackGenerator.swift
//  PwLocker
//
//  Created by Tavares on 12/10/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import Foundation

extension UIViewController {
    
    func mediumVibration() {
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
    
    func successVibration() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func errorVibration() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}
