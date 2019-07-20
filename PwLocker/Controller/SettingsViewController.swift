//
//  SettingsViewController.swift
//  PwLocker
//
//  Created by Tavares on 26/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let sectionHeaderTitles = ["Data Protection", "About the app", "Contact"]
    let segueTwoDimensionID = [
        ["PinCodeSegue", "DeleteAllSegue"],
        ["PrivacySegue", "CreditsSegue"],
        ["ContactUsSegue"]
    ]
    let twoDimensionalArray = [
        ["Change Master Key", "Delete all my data"],
        ["Privacy Policy", "Credits"],
        ["Contact Us"]
    ]
    let twoDimensionImageArray = [
        [ #imageLiteral(resourceName: "locked-padlock"), #imageLiteral(resourceName: "rubbish-bin")],
        [ #imageLiteral(resourceName: "privacy"), #imageLiteral(resourceName: "thank-you")],
        [ #imageLiteral(resourceName: "close-envelope")]
    ]
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.tableFooterView = UIView()
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderSettingCell") as! HeaderSettingTableViewCell
        cell.titleHeaderLabel.text = sectionHeaderTitles[section]
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twoDimensionalArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingsTableViewCell
        let settingImage = twoDimensionImageArray[indexPath.section][indexPath.row]
        let settingTitle = twoDimensionalArray[indexPath.section][indexPath.row]
        cell.titleLabel.text = settingTitle
        cell.settingsImageView.image = settingImage
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueTwoDimensionID[indexPath.section][indexPath.row], sender: self)
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
