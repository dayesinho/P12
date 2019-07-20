//
//  SaveNoteViewController.swift
//  PwLocker
//
//  Created by Tavares on 09/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import RealmSwift
import TwicketSegmentedControl

class SaveNoteViewController: UIViewController {
    
    let noteObject = NoteObject()
    let realm = try? Realm()
    let darkGray = UIColor(red: 85/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1)
    let customGray = UIColor(red: 40/255.0, green: 40/255.0, blue: 40/255.0, alpha: 1)
    let green = UIColor(red: 51/255.0, green: 190/255.0, blue: 98/255.0, alpha: 1)
    
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSegmentControl()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        noteObject.noteTitle = noteTitleTextField.text
        noteObject.noteContent = noteTextView.text
        
        try? realm?.write {
            realm?.add(noteObject)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
         dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setSegmentControl() {
        let titles = ["On", "Off"]
        let frame = CGRect(x: 78, y: 99, width: 160, height: 40)
        let segmentedControl = TwicketSegmentedControl(frame: frame)
        segmentedControl.setSegmentItems(titles)
        segmentedControl.font = UIFont(name: "Gemunu Libre", size: 18)!
        segmentedControl.sliderBackgroundColor = green
        segmentedControl.segmentsBackgroundColor = darkGray
        segmentedControl.delegate = self as? TwicketSegmentedControlDelegate
        segmentedControl.isSliderShadowHidden = false
        segmentedControl.backgroundColor = .clear
        
        view.addSubview(segmentedControl)
    }
}

