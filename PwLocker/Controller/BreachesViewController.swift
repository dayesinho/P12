//
//  BreachesViewController.swift
//  PwLocker
//
//  Created by Tavares on 27/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import TwicketSegmentedControl

class BreachesViewController: UIViewController {

    let darkGray = UIColor(red: 85/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1)
    let customGray = UIColor(red: 40/255.0, green: 40/255.0, blue: 40/255.0, alpha: 1)
    let green = UIColor(red: 51/255.0, green: 190/255.0, blue: 98/255.0, alpha: 1)
    
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordView.alpha = 1
        setSegmentControl()
    }
    
    fileprivate func setSegmentControl() {
        let titles = ["Password", "Email Address"]
        let frame = CGRect(x: 5, y: 20, width: view.frame.width - 10, height: 40)
        let segmentedControl = TwicketSegmentedControl(frame: frame)
        segmentedControl.setSegmentItems(titles)
        segmentedControl.font = UIFont(name: "Gemunu Libre", size: 18)!
        segmentedControl.sliderBackgroundColor = green
        segmentedControl.segmentsBackgroundColor = darkGray
        segmentedControl.delegate = self
        segmentedControl.isSliderShadowHidden = false
        segmentedControl.backgroundColor = .clear
        
        view.addSubview(segmentedControl)
    }
}

extension BreachesViewController: TwicketSegmentedControlDelegate {
    func didSelect(_ segmentIndex: Int) {
        if segmentIndex == 0 {
            passwordView.alpha = 1
            emailView.alpha = 0
        } else {
            passwordView.alpha = 0
            emailView.alpha = 1
        }
    }
}
