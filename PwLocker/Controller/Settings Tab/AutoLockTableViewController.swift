//
//  AutoLockTableViewController.swift
//  PwLocker
//
//  Created by Tavares on 23/10/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit

class AutoLockTableViewController: UITableViewController, BEMCheckBoxDelegate {
    
    @IBOutlet var autoLockTableView: UITableView!
    @IBOutlet weak var tenSecondsBox: BEMCheckBox!
    @IBOutlet weak var thirtySecondsBox: BEMCheckBox!
    @IBOutlet weak var oneMinuteBox: BEMCheckBox!
    @IBOutlet weak var fiveMinutesBox: BEMCheckBox!
    @IBOutlet weak var tenMinuteBox: BEMCheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tenSecondsBox.delegate = self
        thirtySecondsBox.delegate = self
        oneMinuteBox.delegate = self
        fiveMinutesBox.delegate = self
        tenMinuteBox.delegate = self
        autoLockTableView.tableFooterView = UIView()
        detectAutoLockChoosen()
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        
        switch checkBox.tag {
        case 0: UserDefaults.standard.set(10, forKey: "AutoLock")
        thirtySecondsBox.on = false
        oneMinuteBox.on = false
        fiveMinutesBox.on = false
        tenMinuteBox.on = false
        case 1: UserDefaults.standard.set(30, forKey: "AutoLock")
        tenSecondsBox.on = false
        oneMinuteBox.on = false
        fiveMinutesBox.on = false
        tenMinuteBox.on = false
        case 2: UserDefaults.standard.set(60, forKey: "AutoLock")
        tenSecondsBox.on = false
        thirtySecondsBox.on = false
        fiveMinutesBox.on = false
        tenMinuteBox.on = false
        case 3: UserDefaults.standard.set(300, forKey: "AutoLock")
        tenSecondsBox.on = false
        thirtySecondsBox.on = false
        oneMinuteBox.on = false
        tenMinuteBox.on = false
        case 4: UserDefaults.standard.set(600, forKey: "AutoLock")
        tenSecondsBox.on = false
        thirtySecondsBox.on = false
        oneMinuteBox.on = false
        fiveMinutesBox.on = false
        default:
            break
        }
    }
    
    private func detectAutoLockChoosen() {
        
        let autoLock = UserDefaults.standard.object(forKey: "AutoLock") as? Int64
        
        switch autoLock {
        case 10:
            tenSecondsBox.on = true
            oneMinuteBox.on = false
        case 30:
            thirtySecondsBox.on = true
            oneMinuteBox.on = false
        case 60:
            oneMinuteBox.on = true
        case 300:
            fiveMinutesBox.on = true
            oneMinuteBox.on = false
        case 600:
            tenMinuteBox.on = true
            oneMinuteBox.on = false
        default:
            break
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
}
