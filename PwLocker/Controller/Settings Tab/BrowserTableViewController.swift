//
//  BrowserTableViewController.swift
//  PwLocker
//
//  Created by Tavares on 13/10/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit

class BrowserTableViewController: UITableViewController, BEMCheckBoxDelegate {

    let green = UIColor(red: 51/255.0, green: 190/255.0, blue: 98/255.0, alpha: 1)
    @IBOutlet var browserTableView: UITableView!
    @IBOutlet weak var safariBox: BEMCheckBox!
    @IBOutlet weak var chromeBox: BEMCheckBox!
    @IBOutlet weak var firefoxBox: BEMCheckBox!
    @IBOutlet weak var braveBox: BEMCheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        safariBox.delegate = self
        chromeBox.delegate = self
        firefoxBox.delegate = self
        braveBox.delegate = self
        detectLastBrowserSelected()
        browserTableView.tableFooterView = UIView()
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        
        switch checkBox.tag {
            case 0: UserDefaults.standard.set("https://", forKey: "BrowserPrefix")
                chromeBox.on = false
                firefoxBox.on = false
                braveBox.on = false
            case 1: UserDefaults.standard.set("googlechrome://", forKey: "BrowserPrefix")
                safariBox.on = false
                firefoxBox.on = false
                braveBox.on = false
            case 2: UserDefaults.standard.set("firefox://open-url?url=http://", forKey: "BrowserPrefix")
                safariBox.on = false
                chromeBox.on = false
                braveBox.on = false
            case 3: UserDefaults.standard.set("brave://open-url?url=http://", forKey: "BrowserPrefix")
                safariBox.on = false
                chromeBox.on = false
                firefoxBox.on = false
            default:
                break
        }
    }
    
    func detectLastBrowserSelected() {
        
        let browserPrefix = UserDefaults.standard.object(forKey: "BrowserPrefix") as? String
        if browserPrefix == "googlechrome://" {
            chromeBox.on = true
            safariBox.on = false
        } else if browserPrefix == "firefox://open-url?url=http://" {
            firefoxBox.on = true
            safariBox.on = false
        } else if browserPrefix == "brave://open-url?url=http://" {
            braveBox.on = true
            safariBox.on = false
        } else if browserPrefix == "https://" {
            safariBox.on = true
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}
