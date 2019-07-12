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
    
    var item: RSSItem! {
        didSet {
            titleLabel.text = item.title
            publishDateLabel.text = "Posted on: " + item.pubDate.removeLastTenCharacters.removeFirstFourCharacters
            descriptionTextView.text = item.description.html2AttributedString
        }
    }
}
