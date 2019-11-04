//
//  BiometricSettingsViewController.swift
//  PwLocker
//
//  Created by Tavares on 02/11/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import LocalAuthentication

class BiometricSettingsViewController: UIViewController {

    @IBOutlet weak var biometricTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        biometricTableView.tableFooterView = UIView()
        view.addSubview(UIView(frame: .zero))
        view.addSubview(biometricTableView)
    }
    
     @objc func didTap(_ checkBox: BEMCheckBox) {
        
        if checkBox.on {
            UserDefaults.standard.set("StoryB", forKey: "LoginPage")
        } else {
            UserDefaults.standard.set("StoryA", forKey: "LoginPage")
        }
    }
    
    func detectBiometricType() -> String {
    let context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            if context.biometryType == .faceID {
              return "Face ID"
            }
        }
        return "Touch ID"
    }
}

extension BiometricSettingsViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderBiometricCell")
        cell?.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BiometricCell", for: indexPath) as! BiometricTableViewCell
        cell.biometricBox.addTarget(self, action: #selector(didTap(_:)), for: .valueChanged)
        cell.biometricLabel.text = detectBiometricType()
        cell.selectionStyle = .none
        return cell
    }
    
    
}

extension BiometricSettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
