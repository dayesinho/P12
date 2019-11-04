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

    var websiteObject: WebsiteObject?
    
    @IBOutlet weak var websitesTableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        websitesTableView.reloadData()
        self.view.addSubview(UIView(frame: .zero))
        self.view.addSubview(websitesTableView)
        websitesTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        websitesTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailWebsiteViewController = segue.destination as? DetailWebsiteTableViewController {
            detailWebsiteViewController.websiteObject = websiteObject
        }
    }
}

extension WebsitesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        let configuration = Realm.Configuration(encryptionKey: getKey() as Data)
        let realm = try? Realm(configuration: configuration)
        let websiteArray = realm?.objects(WebsiteObject.self)
        return websiteArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let configuration = Realm.Configuration(encryptionKey: getKey() as Data)
        let realm = try? Realm(configuration: configuration)
        let websiteArray = realm?.objects(WebsiteObject.self)
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "WebsiteCell", for: indexPath) as! WebsiteTableViewCell
        
        cell.selectionStyle = .none
        cell.websiteCell = websiteArray?[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        websitesTableView.isUserInteractionEnabled = true
        
        let configuration = Realm.Configuration(encryptionKey: getKey() as Data)
        let realm = try? Realm(configuration: configuration)
        let websiteArray = realm?.objects(WebsiteObject.self)
        
        websiteObject = websiteArray?[indexPath.row]
        self.performSegue(withIdentifier: "TransferWebsite", sender: self)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "You have no websites saved"
        label.font = UIFont(name: "GemunuLibre-SemiBold", size: 20)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }
    
    internal func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let configuration = Realm.Configuration(encryptionKey: getKey() as Data)
        let realm = try? Realm(configuration: configuration)
        guard let websiteArray = realm?.objects(WebsiteObject.self) else { return 0}
        return websiteArray.isEmpty ? 200 : 0
    }
}

extension WebsitesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
