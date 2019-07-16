//
//  DetailNoteViewController.swift
//  PwLocker
//
//  Created by Tavares on 09/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import RealmSwift

class DetailNoteViewController: UIViewController {
    
    let realm = try! Realm()
    var noteObject: NoteObject?
    
    @IBOutlet weak var noteContentTextView: UITextView!
    @IBOutlet weak var deleteButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        showNoteDetails()
        let rightButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: #selector(rightBarButtonTapped(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func rightBarButtonTapped(sender: UIBarButtonItem) {
        if noteContentTextView.isUserInteractionEnabled == true {
            UIView.animate(withDuration: 1, delay: 0, options: [.allowUserInteraction], animations: {
                self.deleteButton.alpha = 0
            }, completion: nil)
            navigationItem.rightBarButtonItem?.title = "Edit"
            noteContentTextView.isUserInteractionEnabled = false
        } else {
            UIView.animate(withDuration: 1, delay: 0, options: [.allowUserInteraction], animations: {
                self.deleteButton.alpha = 1
                }, completion: nil)
             navigationItem.rightBarButtonItem?.title = "Done"
            noteContentTextView.isUserInteractionEnabled = true
        }
    }

    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let noteObjectUnwrapped = noteObject else { return }
                    try? realm.write {
                    realm.delete(noteObjectUnwrapped)
                }
                _ = navigationController?.popViewController(animated: true)
    }
    
    func showNoteDetails() {
        navigationItem.title = noteObject?.noteTitle
        noteContentTextView.text = noteObject?.noteContent
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
