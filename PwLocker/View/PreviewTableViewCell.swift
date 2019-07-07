//
//  PreviewTableViewCell.swift
//  PwLocker
//
//  Created by Tavares on 29/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import FavIcon
import KeychainSwift

class PreviewTableViewCell: UITableViewCell {
    
    let keychain = KeychainSwift()
     var url = "www.facebook.com"
    
    @IBOutlet weak var favIconImageView: UIImageView!
    @IBOutlet weak var websiteLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var previewCells: Keys! {
        didSet {
            guard let nameData = keychain.getData(Keys.forName) else { return }
//            guard let urlFavIconData = keychain.getData(Keys.forWebsite) else { return }
            
            let website = String(decoding: nameData, as: UTF8.self)
//            url = String(decoding: urlFavIconData, as: UTF8.self)
            
            websiteLabel.text = website
            getFavIcon()
        }
    }
    
    func getFavIcon() {
        do {
            try FavIcon.downloadPreferred(url, width: 200, height: 200) { result in
                if case let .success(image) = result {
                    self.favIconImageView.image = image
                } else if case let .failure(error) = result {
                    print("failed to download preferred favicon for \(self.url): \(error)")
                }
            }
        } catch let error {
            print("failed to download preferred favicon for \(self.url): \(error)")
        }
    }
}
