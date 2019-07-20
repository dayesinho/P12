//
//  TextView.swift
//  PwLocker
//
//  Created by Tavares on 17/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import Foundation

extension UITextView {
    
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
    
}
