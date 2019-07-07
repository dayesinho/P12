//
//  NewsViewController.swift
//  PwLocker
//
//  Created by Tavares on 29/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    let breachNewsService = BreachNewsService()
    var newsBreach: [BreachModel]?
    let feedParser = FeedParser()
    private var rssItems: [RSSItem]?
    
    
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        pushNewsBreaches()
        fetchData()
    }
    
     func fetchData() {
        toggleActivityIndicator(loadingLabel: loadingLabel, activityIndicator: activityIndicator, shown: true)
        feedParser.parseFeed(url: "https://feeds.feedburner.com/HaveIBeenPwnedLatestBreaches?format=xml") { (rssItems) in
            self.toggleActivityIndicator(loadingLabel: self.loadingLabel, activityIndicator: self.activityIndicator, shown: false)
            self.rssItems = rssItems
            
            OperationQueue.main.addOperation {
                self.newsTableView.reloadSections(IndexSet(integer: 0), with: .left)
            }
        }
    }
    
    
    func pushNewsBreaches() {
        toggleActivityIndicator(loadingLabel: loadingLabel, activityIndicator: activityIndicator, shown: true)
        breachNewsService.getBreachesNews { (success, breachNews) in
            self.toggleActivityIndicator(loadingLabel: self.loadingLabel, activityIndicator: self.activityIndicator, shown: false)
            if success, let breachNews = breachNews {
                self.newsBreach = breachNews
                self.newsTableView.reloadData()
            } else {
                self.showAlert(title: "Error", message: "We couldn't load the news, sorry.")
            }
        }
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rssItems = rssItems else { return 0 }
//        guard let newsUnwrap = newsBreach else { return 0 }
//        return newsUnwrap.count
        return rssItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let newsData = newsBreach?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        if let item = rssItems?[indexPath.item] {
            cell.item = item
        }
        cell.selectionStyle = .none
//        cell.breachNews = newsData
        return cell
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
}
