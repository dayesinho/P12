//
//  EmailTableViewCell.swift
//  PwLocker
//
//  Created by Tavares on 01/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit

class EmailTableViewCell: UITableViewCell {

    @IBOutlet weak var websitePwnedLabel: UILabel!
    @IBOutlet weak var datePwnedLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var websiteImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var emailPwned: EmailBreachModel! {
        didSet {
            websitePwnedLabel.text = emailPwned.name
            datePwnedLabel.text = emailPwned.beachDate
            descriptionTextView.text = emailPwned.detail.html2AttributedString
            guard let imageURL = URL(string: emailPwned.logoPath) else { return }
            if let imageFromURL = try? Data(contentsOf: imageURL) {
                websiteImageView.image = UIImage(data: imageFromURL)
            } else {
                websiteImageView.image = UIImage(named: "key")
            }
        }
    }
}
