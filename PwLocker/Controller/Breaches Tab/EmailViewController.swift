//
//  EmailController.swift
//  PwLocker
//
//  Created by Tavares on 27/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController {
    
    let emailService = EmailService()
    var emailBreach: [EmailBreachModel]?
    let red = UIColor(red: 148/255.0, green: 32/255.0, blue: 41/255.0, alpha: 1)
    let green = UIColor(red: 51/255.0, green: 190/255.0, blue: 98/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleActivityIndicator(loadingLabel: loadingLabel, activityIndicator: activityIndicator, shown: false)
        emailAddressTextField.roundCorners(corners: [.topLeft, .bottomLeft], radius: 20)
        searchButton.roundCorners(corners: [.topRight, .bottomRight], radius: 20)
    }
    
    @IBOutlet weak var emailBreachTableView: UITableView!
    @IBOutlet weak var emailAddressTextField: UITextField! {
        didSet {
            emailAddressTextField.tintColor = UIColor.lightGray
            emailAddressTextField.setIcon(#imageLiteral(resourceName: "email"))
        }
    }
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var noPwnageView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var clearNoPwnageResultsButton: UIButton!
    
    
    
    @IBAction func validationButton(_ sender: UIButton) {
        
        noPwnageView.alpha = 0
        guard let account = emailAddressTextField.text else { return }
        
        toggleActivityIndicator(loadingLabel: loadingLabel, activityIndicator: activityIndicator, shown: true)
        emailAddressTextField.resignFirstResponder()
        emailService.getEmailBreach(account: account) { (success, emailBreach) in
            self.toggleActivityIndicator(loadingLabel: self.loadingLabel, activityIndicator: self.activityIndicator, shown: false)
            if success, let emailBreach = emailBreach {
                self.emailBreach = emailBreach
                self.emailBreachTableView.isHidden = false
                self.emailBreachTableView.reloadData()
            } else {
                self.noPwnageView.alpha = 1
                self.clearNoPwnageResultsButton.isHidden = false
                self.emailBreachTableView.isHidden = true
            }
        }
    }
    
    @IBAction func clearPwnageResultsButtonTapped(_ sender: Any) {
        noPwnageView.alpha = 0
        clearNoPwnageResultsButton.isHidden = true
        emailBreachTableView.isHidden = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension EmailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let emailBreacheUnwrap = emailBreach else { return 0 }
        return emailBreacheUnwrap.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let emailData = emailBreach?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmailCell", for: indexPath) as! EmailTableViewCell
        cell.selectionStyle = .none
        cell.emailPwned = emailData
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmailHeaderCell") as! HeaderEmailTableViewCell
        
        guard let pwndNumber = emailBreach?.count else { return nil }
        
        cell.headerLabel.text = "Pwned on \(pwndNumber) breached sites"
        cell.headerView.backgroundColor = red
        
        return cell
    }
}


extension EmailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}
