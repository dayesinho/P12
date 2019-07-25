//
//  PreviewTableViewCell.swift
//  PwLocker
//
//  Created by Tavares on 29/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
//import SDWebImage

class WebsiteTableViewCell: UITableViewCell {
    
    let urlForFavIcon = "https://api.faviconkit.com/"
    
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var favIconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var websiteCell: WebsiteObject! {
        didSet {
            websiteLabel.text = websiteCell.name
             let urlSaved = websiteCell.website
            
//            let url = NSURL(string: urlSaved)
//            guard let domain = url?.host else { return }
            
            guard let imageMainURL = URL(string: urlForFavIcon + urlSaved + "/144") else { return }
//            guard let imageSecondaryURL = URL(string: urlForFavIcon + domain + "/144") else { return }
            
            if let imageFromURL = try? Data(contentsOf: imageMainURL) {
                 favIconImageView.image = UIImage(data: imageFromURL)
            } else {
               favIconImageView.image = UIImage(named: "key")
            }
            
        }
    }
}
