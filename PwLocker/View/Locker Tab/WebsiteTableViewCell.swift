//
//  PreviewTableViewCell.swift
//  PwLocker
//
//  Created by Tavares on 29/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit

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
            let imageMainURL = urlForFavIcon + urlSaved + "/144"

            loadImage(fromURL: imageMainURL)
        }
    }
    
    public func loadImage(fromURL url: String) {
        
        let urlSaved = websiteCell.website
        
        guard let imageURL = URL(string: urlForFavIcon + urlSaved + "/144") else {
            return
        }
        
        let cache =  URLCache.shared
        let request = URLRequest(url: imageURL)
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.transition(toImage: image)
                }
            } else {
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                            self.transition(toImage: image)
                        }
                    }
                }).resume()
            }
        }
    }
    
    public func transition(toImage image: UIImage?) {
        UIView.transition(with: self, duration: 0.1,
                          options: [.transitionCrossDissolve],
                          animations: {
                            self.favIconImageView.image = image
        },
                          completion: nil)
    }
}

