//
//  NotesViewController.swift
//  PwLocker
//
//  Created by Tavares on 08/07/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import RealmSwift

class NotesViewController: UIViewController {
    
    let realm = try? Realm()
    var noteObject: NoteObject?
    
    @IBOutlet weak var notesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        notesTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailNoteViewController = segue.destination as? DetailNoteViewController {
            detailNoteViewController.noteObject = noteObject
        }
    }
}

extension NotesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let noteArray = realm?.objects(NoteObject.self)
        return noteArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let noteArray = realm?.objects(NoteObject.self)
        let previewNoteData = noteArray?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableViewCell
        cell.selectionStyle = .none
        cell.noteCell = previewNoteData
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        notesTableView.isUserInteractionEnabled = true
        
        let noteArray = realm?.objects(NoteObject.self)
        noteObject = noteArray?[indexPath.row]
        self.performSegue(withIdentifier: "TransferNote", sender: self)
    }
}

extension NotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
