//
//  DeleteAllViewController.swift
//  PwLocker
//
//  Created by Tavares on 13/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import RealmSwift

class DeleteAllViewController: UIViewController {

    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        showDeleteAlert(title: "Last warning!", message: "Do you really want delete all your data?")
    }
    
    func showDeleteAlert(title: String, message: String) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertVC.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: { (action) in
            alertVC.dismiss(animated: true, completion: nil)
            self.deleteAll()
        }))
        
        alertVC.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: { (action) in
            alertVC.dismiss(animated: true, completion: nil) }))
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
}