//
//  LockerViewController.swift
//  PwLocker
//
//  Created by Tavares on 26/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import TwicketSegmentedControl
import RealmSwift

class LockerViewController: UIViewController {

    let darkGray = UIColor(red: 85/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1)
    let customGray = UIColor(red: 40/255.0, green: 40/255.0, blue: 40/255.0, alpha: 1)
    let green = UIColor(red: 51/255.0, green: 190/255.0, blue: 98/255.0, alpha: 1)
    var effect: UIVisualEffect!
    
    @IBOutlet weak var websiteView: UIView!
    @IBOutlet weak var scanView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        scanView.alpha = 0
        setSegmentControl()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    fileprivate func setSegmentControl() {
        let titles = ["Websites", "Security Scan"]
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
    
    @IBAction func addButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "addWebsiteSegue", sender: self)
    }
}

extension LockerViewController: TwicketSegmentedControlDelegate {
    func didSelect(_ segmentIndex: Int) {
        if segmentIndex == 0 {
            websiteView.alpha = 1
            scanView.alpha = 0
        } else {
            websiteView.alpha = 0
            scanView.alpha = 1
        }
    }
}
