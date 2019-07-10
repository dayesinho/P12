//
//  DetailNoteViewController.swift
//  PwLocker
//
//  Created by Tavares on 09/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit

class DetailNoteViewController: UIViewController {
    
    var noteObject: NoteObject?
    
    @IBOutlet weak var noteTitleLabel: UILabel!
    @IBOutlet weak var noteContentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showNoteDetails()
    }
    
    func showNoteDetails() {
        noteTitleLabel.text = noteObject?.noteTitle
        noteContentTextView.text = noteObject?.noteContent
    }
    
    
}
