//
//  WebsitesViewController.swift
//  PwLocker
//
//  Created by Tavares on 08/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import RealmSwift

class WebsitesViewController: UIViewController {

    let realm = try? Realm()
    var websiteObject: WebsiteObject?
    
    @IBOutlet weak var websitesTableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        websitesTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        websitesTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailsViewController = segue.destination as? DetailWebsiteViewController {
            detailsViewController.websiteObject = websiteObject
        }
    }
}

extension WebsitesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let websiteArray = realm?.objects(WebsiteObject.self)
        
        return websiteArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let websiteArray = realm?.objects(WebsiteObject.self)
        let previewWebsiteData = websiteArray?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WebsiteCell", for: indexPath) as! WebsiteTableViewCell
        cell.selectionStyle = .none
        cell.websiteCell = previewWebsiteData
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        websitesTableView.isUserInteractionEnabled = true
        
        let websiteArray = realm?.objects(WebsiteObject.self)
        websiteObject = websiteArray?[indexPath.row]
        self.performSegue(withIdentifier: "TransferWebsite", sender: self)
    }
}

extension WebsitesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
