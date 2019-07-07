//
//  LockerViewController.swift
//  PwLocker
//
//  Created by Tavares on 26/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import KeychainSwift
import TwicketSegmentedControl

class LockerViewController: UIViewController {

    let darkGray = UIColor(red: 85/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1)
    let customGray = UIColor(red: 40/255.0, green: 40/255.0, blue: 40/255.0, alpha: 1)
    let green = UIColor(red: 51/255.0, green: 190/255.0, blue: 98/255.0, alpha: 1)
    var previewCells: [Keys]?
 
    @IBOutlet weak var lockerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lockerTableView.reloadData()
        setSegmentControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lockerTableView.reloadData()
    }
    
    fileprivate func setSegmentControl() {
        let titles = ["Websites/Apps", "Notes"]
        let frame = CGRect(x: 5, y: 20, width: view.frame.width - 10, height: 40)
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

extension LockerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let previewData = previewCells?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreviewCell", for: indexPath) as! PreviewTableViewCell
        cell.selectionStyle = .none
        cell.previewCells = previewData
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.isUserInteractionEnabled = true
    }
}

extension LockerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
