//
//  ScanViewController.swift
//  PwLocker
//
//  Created by Tavares on 08/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import RealmSwift
import Navajo_Swift

class ScanViewController: UIViewController {
    
    let passwordService = PasswordService()
    let scanHeaderTitles = ["Low Secured Passwords:", "Compromised Passwords:"]
    let urlForFavIcon = "https://api.faviconkit.com/"
    var pwndTimesArray = [UInt]()
    var lowSecurePasswordStrengthArray = [String]()
    var lowSecureWebsitesArray = [WebsiteObject]()
    var compromisedWebsitesArray = [WebsiteObject]()
    var countFired: CGFloat = 0
    var websiteObject: WebsiteObject?
    
    let green = UIColor(red: 51/255.0, green: 190/255.0, blue: 98/255.0, alpha: 1)
    
    @IBOutlet weak var scanTableView: UITableView!
    @IBOutlet weak var progressBar: ProgressBar!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        scanTableView.tableFooterView = UIView()
        scanTableView.isHidden = true
        scanTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scanTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scanTableView.reloadData()
    }
 
    @IBAction func scanButtonTapped(_ sender: UIButton) {
        lowSecureWebsitesArray.removeAll()
        lowSecurePasswordStrengthArray.removeAll()
        compromisedWebsitesArray.removeAll()
        
        mediumVibration()
        checkPasswordStrength()
        checkCompromisedPasswords()
        
        countFired = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.countFired += 1
            
            DispatchQueue.main.async {
                self.progressBar.progress = min(0.07 * self.countFired, 1)
                
                if self.progressBar.progress == 1 {
                    self.scanTableView.isHidden = false
                    timer.invalidate()
                }
            }
        }
        
        if countFired != 1 {
            scanTableView.isHidden = true
        } else {
            scanTableView.isHidden = false
        }
    }

    fileprivate func checkCompromisedPasswords() {
        
        let configuration = Realm.Configuration(encryptionKey: getKey() as Data)
        let realm = try? Realm(configuration: configuration)
        guard let websiteArray = realm?.objects(WebsiteObject.self) else { return }
        
        for website in websiteArray {
            self.scanTableView.reloadData()
            _ = try? self.passwordService.search(password: website.password) { result in
                if let pwnedTimes = try? result() {
                    DispatchQueue.main.async {
                        if pwnedTimes > 0 {
                            self.compromisedWebsitesArray.append(website)
                            self.pwndTimesArray.append(pwnedTimes)
                            self.scanTableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    fileprivate func checkPasswordStrength() {
        
        let configuration = Realm.Configuration(encryptionKey: getKey() as Data)
        let realm = try? Realm(configuration: configuration)
        guard let websiteArray = realm?.objects(WebsiteObject.self) else { return }
        
        for website in websiteArray {
            let strength = Navajo.strength(ofPassword: website.password)
            let strengthString = Navajo.localizedString(forStrength: strength)
            if strengthString != "Very Strong" {
                lowSecureWebsitesArray.append(website)
                lowSecurePasswordStrengthArray.append(strengthString)
                scanTableView.reloadData()
            }
        }
    }
    
    fileprivate func changeStrengthColors() -> [UIColor] {
        
        var colorArray = [UIColor]()
        for strength in lowSecurePasswordStrengthArray {
            switch strength {
            case "Very Weak":
                colorArray.append(UIColor.red)
            case "Weak":
                colorArray.append(UIColor(red: 255/255.0, green: 38/255.0, blue: 0/255.0, alpha: 1))
            case "Reasonable":
                colorArray.append(UIColor.orange)
            case "Strong":
                colorArray.append(UIColor(red: 142/255.0, green: 250/255.0, blue: 0/255.0, alpha: 1))
            case "Very Strong":
                colorArray.append(UIColor.green)
            default:
                break
            }
        }
        return colorArray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailWebsiteViewController = segue.destination as? DetailWebsiteTableViewController {
            detailWebsiteViewController.websiteObject = websiteObject
        }
    }
}

extension ScanViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderScanCell") as! HeaderScanTableViewCell
        cell.headerScanLabel.text = scanHeaderTitles[section]
        let counter = section == 0 ? String(lowSecureWebsitesArray.count) : String(compromisedWebsitesArray.count)
        cell.counterScanLabel.text = counter
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return lowSecureWebsitesArray.count
        }
        return compromisedWebsitesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LowSecureScanCell", for: indexPath) as! LowSecureTableViewCell
        
        let lowSecurePassword = indexPath.section == 0 ? lowSecureWebsitesArray[indexPath.row].name : compromisedWebsitesArray[indexPath.row].name
        
        let lowStrength = indexPath.section == 0 ? lowSecurePasswordStrengthArray[indexPath.row] : pwndTimesArray[indexPath.row].roundedWithAbbreviations + " times"
        
    if indexPath.section == 0 {
           cell.resultStrengthLabel.textColor = changeStrengthColors()[indexPath.row]
        } else {
            cell.resultStrengthLabel.textColor = UIColor.lightGray
        }

        cell.resultNameLabel.text = lowSecurePassword
        cell.resultStrengthLabel.text = lowStrength
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        scanTableView.isUserInteractionEnabled = true
    
        if indexPath.section == 0 {
            websiteObject = lowSecureWebsitesArray[indexPath.row]
            performSegue(withIdentifier: "ShowDetailSegue", sender: self)
        } else {
            websiteObject = compromisedWebsitesArray[indexPath.row]
            performSegue(withIdentifier: "ShowDetailSegue", sender: self)
        }
    }
}

extension ScanViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
