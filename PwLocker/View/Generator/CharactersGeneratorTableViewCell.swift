//
//  CharactersGeneratorTableViewCell.swift
//  PwLocker
//
//  Created by Tavares on 28/10/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit

class CharactersGeneratorTableViewCell: UITableViewCell, BEMCheckBoxDelegate {

    @IBOutlet weak var charactersLabel: UILabel!
    @IBOutlet weak var charactersBox: BEMCheckBox!

    override func awakeFromNib() {
        super.awakeFromNib()
        charactersBox.delegate = self
    }
}
