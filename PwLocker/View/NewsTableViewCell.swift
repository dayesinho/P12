//
//  NewsTableViewCell.swift
//  PwLocker
//
//  Created by Tavares on 01/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    var breachNews: BreachModel! {
//        didSet {
//            
//            titleLabel.text = breachNews.name
//            publishDateLabel.text = "Posted: " + breachNews.addedDate.asString(style: .long)
//            descriptionTextView.text = breachNews.description.html2AttributedString
//            // to add: "Accounts pwned:" + String(breachNews.pwnCount)
//            guard let imageURL = URL(string: breachNews.logoPath) else { return }
//            if let imageFromURL = try? Data(contentsOf: imageURL) {
//                newsImageView.image = UIImage(data: imageFromURL)
//            } else {
//                newsImageView.image = UIImage(named: "key")
//            }
//        }
//    }
    
    var item: RSSItem! {
        didSet {
            titleLabel.text = item.title
            publishDateLabel.text = item.pubDate
            descriptionTextView.text = item.description.html2AttributedString
        }
    }
}
