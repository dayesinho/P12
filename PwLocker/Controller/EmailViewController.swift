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
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    
    
    @IBAction func validationButton(_ sender: UIButton) {
     
        guard let account = emailAddressTextField.text else { return }
        
        emailService.getEmailBreach(account: account) { (success, emailBreach) in
            if success, let emailBreach = emailBreach {
                self.emailBreach = emailBreach
                self.emailBreachTableView.reloadData()
                self.pwnedPresentation(pwnedNumber: emailBreach.count)
            } else {
                self.emailBreach = emailBreach
                self.emailBreachTableView.reloadData()
                self.notPwnedPresentation()
            }
        }
    }
    
    func pwnedPresentation(pwnedNumber: Int) {
        DispatchQueue.main.async {
            self.resultView.layer.borderWidth = 2
            self.resultView.backgroundColor = self.red
            self.resultLabel.text = "Pwned on \(pwnedNumber) breached sites"
        }
    }
    
    func notPwnedPresentation() {
        DispatchQueue.main.async {
            self.resultView.layer.borderWidth = 2
            self.resultView.backgroundColor = self.green
            self.resultLabel.text = "Good news — No pwnage found!"
        }
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
}

extension EmailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
}
