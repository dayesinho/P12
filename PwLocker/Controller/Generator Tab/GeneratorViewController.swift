//
//  GeneratorTestViewController.swift
//  PwLocker
//
//  Created by Tavares on 28/10/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit
import Navajo_Swift

class GeneratorViewController: UIViewController {
    
    let sectionHeaderTitles = ["Length:", "Type of characters:"]
    let twoDimensionalArray = [["1"],["1", "2"]]
    let titleCharacters = ["Numbers", "Special Characters"]
    let green = UIColor(red: 51/255.0, green: 190/255.0, blue: 98/255.0, alpha: 1)
    let letters: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let numbers: String = "0123456789"
    let specialChar: String  = "!#$%&()'*+,-./:;<=>?@[]^_`{|}~"
    var charactersArray = [String]()
    var numberOfChar = Int(22)
    var length = String("22")
    
    @IBOutlet weak var generatorTableView: UITableView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var strengthPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        charactersArray = [letters , numbers , specialChar]
        generatorTableView.tableFooterView = UIView()
        view.addSubview(UIView(frame: .zero))
        view.addSubview(generatorTableView)
        passwordTextField.roundCorners(corners: [.topLeft, .bottomLeft], radius: 50.0)
        passwordTextField.text = generateRandomString(numberOfCharacters: 22)
        checkPasswordStrength()
        generatorTableView.reloadData()
    }
    
    @objc func sliderValueChange(sender: UISlider) {
        numberOfChar = Int(sender.value)
        passwordTextField.text = generateRandomString(numberOfCharacters: numberOfChar)
        checkPasswordStrength()
    }
    
    @objc func getLength(sender: UISlider) -> String {
        length = String(Int(sender.value))
        generatorTableView.reloadData()
        return length
    }
    
    @objc func didTap(_ checkBox: BEMCheckBox) {
        
        if checkBox.on == true {
            switch checkBox.tag {
            case 0: charactersArray.append(numbers)
            case 1: charactersArray.append(specialChar)
            default:
                break
            }
            passwordTextField.text = generateRandomString(numberOfCharacters: numberOfChar)
        } else {
            switch checkBox.tag {
            case 0: charactersArray.removeAll { $0 == numbers }
            case 1: charactersArray.removeAll { $0 == specialChar }
            default:
                break
            }
            passwordTextField.text = generateRandomString(numberOfCharacters: numberOfChar)
        }
    }
    
    @IBAction func generateNewPassword(_ sender: Any) {
        mediumVibration()
        passwordTextField.text = generateRandomString(numberOfCharacters: numberOfChar)
        checkPasswordStrength()
    }
    
    @IBAction func copyButtonTapped(_ sender: Any) {
        mediumVibration()
        copyButton.isEnabled = false
        UIPasteboard.general.string = passwordTextField.text
        copyButton.backgroundColor = UIColor.darkGray
        
        UIView.animate(withDuration: 1, delay: 0.3, options: [.allowUserInteraction], animations: {
            self.copyButton.setTitle("Copied!", for: UIControl.State.normal)
            self.copyButton.backgroundColor = self.green
        }, completion: { _ in
            self.copyButton.setTitle("Copy", for: UIControl.State.normal)
            self.copyButton.isEnabled = true
        })
    }
    
    fileprivate func checkPasswordStrength() {
        
        let password = passwordTextField.text ?? ""
        let strength = Navajo.strength(ofPassword: password)
        strengthPasswordTextField.text = Navajo.localizedString(forStrength: strength)
        changeStrengthColors()
    }
    
    fileprivate func changeStrengthColors() {
        
        let password = passwordTextField.text ?? ""
        let strength = Navajo.strength(ofPassword: password)
        switch strength {
        case .veryWeak:
            strengthPasswordTextField.textColor = UIColor.red
        case .weak:
            strengthPasswordTextField.textColor = UIColor(red: 255/255.0, green: 38/255.0, blue: 0/255.0, alpha: 1)
        case .reasonable:
            strengthPasswordTextField.textColor = UIColor(red: 255/255.0, green: 147/255.0, blue: 0/255.0, alpha: 1)
        case .strong:
            strengthPasswordTextField.textColor = UIColor(red: 142/255.0, green: 250/255.0, blue: 0/255.0, alpha: 1)
        case .veryStrong:
            strengthPasswordTextField.textColor = UIColor.green
        }
    }
    
    fileprivate func generateRandomString(numberOfCharacters: Int) -> String {
        let nsstringRepresentation = NSString(string: charactersArray.joined(separator: ""))
        
        let lenght = UInt32(nsstringRepresentation.length)
        var randomString = ""
        
        for _ in 0 ..< numberOfCharacters {
            let random = arc4random_uniform(lenght)
            var nextCharacter = nsstringRepresentation.character(at: Int(random))
            
            randomString += NSString(characters: &nextCharacter, length: 1) as String
        }
        return randomString
    }
}

extension GeneratorViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderGeneratorCell") as! HeaderGeneratorTableViewCell
        cell.titleHeaderLabel.text = sectionHeaderTitles[section]
        if section == 0 {
           cell.lengthPasswordTextField.text = length
        } else {
            cell.lengthPasswordTextField.text =  ""
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaderTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twoDimensionalArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SliderCell", for: indexPath) as! SliderGeneratorTableViewCell
            cell.sliderGenerator.addTarget(self, action: #selector(sliderValueChange(sender:)), for: .valueChanged)
            cell.sliderGenerator.addTarget(self, action: #selector(getLength(sender:)), for: .valueChanged)
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharactersCell", for: indexPath) as! CharactersGeneratorTableViewCell
            cell.charactersLabel.text = titleCharacters[indexPath.row]
            cell.charactersBox.tag = indexPath.row
            cell.charactersBox.addTarget(self, action: #selector(didTap(_:)), for: .valueChanged)
            cell.selectionStyle = .none
        return cell
        }
    }
}

extension GeneratorViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
