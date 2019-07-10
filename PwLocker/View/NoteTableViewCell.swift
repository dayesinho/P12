//
//  NoteTableViewCell.swift
//  PwLocker
//
//  Created by Tavares on 09/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var noteTitleCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var noteCell: NoteObject! {
        didSet {
            noteTitleCell.text = noteCell.noteTitle
        }
    }

}
