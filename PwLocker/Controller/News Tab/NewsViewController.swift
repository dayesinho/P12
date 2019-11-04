//
//  NewsViewController.swift
//  PwLocker
//
//  Created by Tavares on 29/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    let feedParser = FeedParser()
    private var rssItems: [RSSItem]?
    
    
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        self.view.addSubview(UIView(frame: .zero))
        self.view.addSubview(newsTableView)
    }
    
     private func fetchData() {
        toggleActivityIndicator(loadingLabel: loadingLabel, activityIndicator: activityIndicator, shown: true)
        feedParser.parseFeed(url: "https://feeds.feedburner.com/HaveIBeenPwnedLatestBreaches?format=xml") { (rssItems) in
            self.toggleActivityIndicator(loadingLabel: self.loadingLabel, activityIndicator: self.activityIndicator, shown: false)
            self.rssItems = rssItems
            OperationQueue.main.addOperation {
            self.newsTableView.reloadData()
            }
        }
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let rssItems = rssItems else { return 0 }
        return rssItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        if let item = rssItems?[indexPath.item] {
            cell.item = item
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 60, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
}
