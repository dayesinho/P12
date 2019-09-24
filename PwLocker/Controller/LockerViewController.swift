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
    
    
    @IBOutlet var addNewItemView: UIView!
    @IBOutlet weak var websiteView: UIView!
    @IBOutlet weak var notesView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        notesView.alpha = 0
        effect = visualEffectView.effect
        visualEffectView.effect = nil
        setSegmentControl()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    fileprivate func animateIn() {
        
        self.view.addSubview(addNewItemView)
        addNewItemView.center = self.view.center
        
        addNewItemView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        addNewItemView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.effect = self.effect
            self.addNewItemView.alpha = 1
            self.addNewItemView.transform = CGAffineTransform.identity
        }
    }
    
    fileprivate func animateOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.addNewItemView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.addNewItemView.alpha = 0
            self.visualEffectView.effect = nil
        }) { (sucess: Bool) in
            self.addNewItemView.removeFromSuperview()
        }
    }
    
    fileprivate func setSegmentControl() {
        let titles = ["Websites", "Notes"]
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
    
    @IBAction func addNewWebsitePressed(_ sender: Any) {
        self.performSegue(withIdentifier: "addWebsiteSegue", sender: self)
        animateOut()
    }
    
    
    @IBAction func addNewNotePressed(_ sender: Any) {
        self.performSegue(withIdentifier: "addNoteSegue", sender: self)
        animateOut()
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        animateIn()
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        animateOut()
    }
}

extension LockerViewController: TwicketSegmentedControlDelegate {
    func didSelect(_ segmentIndex: Int) {
        if segmentIndex == 0 {
            websiteView.alpha = 1
            notesView.alpha = 0
        } else {
            websiteView.alpha = 0
            notesView.alpha = 1
        }
    }
}
