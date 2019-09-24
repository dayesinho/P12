//
//  PasswordViewController.swift
//  PwLocker
//
//  Created by Tavares on 26/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit

class GeneratorViewController: UIViewController, BEMCheckBoxDelegate {
    
    let green = UIColor(red: 51/255.0, green: 190/255.0, blue: 98/255.0, alpha: 1)
    let letters: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let numbers: String = "0123456789"
    let specialChar: String  = "!#$%&()'*+,-./:;<=>?@[]^_`{|}~"
    var charactersArray = [String]()
    var numberOfChar = Int(23)
    
    @IBOutlet weak var numberCharTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var numberCharSlider: UISlider!
    @IBOutlet weak var lettersBox: BEMCheckBox!
    @IBOutlet weak var numbersBox: BEMCheckBox!
    @IBOutlet weak var specialCharBox: BEMCheckBox!
    @IBOutlet weak var copyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lettersBox.delegate = self
        numbersBox.delegate = self
        specialCharBox.delegate = self
        passwordTextField.roundCorners(corners: [.topLeft, .bottomLeft], radius: 50.0)
        charactersArray = [letters , numbers , specialChar]
        passwordTextField.text = generateRandomString(numberOfCharacters: 23)
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        
        if checkBox.on == true {
            switch checkBox.tag {
            case 0: charactersArray.append(letters)
            case 1: charactersArray.append(numbers)
            case 2: charactersArray.append(specialChar)
            default:
                break
            }
            passwordTextField.text = generateRandomString(numberOfCharacters: numberOfChar)
        } else {
            switch checkBox.tag {
            case 0: charactersArray.removeAll { $0 == letters }
            case 1: charactersArray.removeAll { $0 == numbers }
            case 2: charactersArray.removeAll { $0 == specialChar }
            default:
                break
            }
            passwordTextField.text = generateRandomString(numberOfCharacters: numberOfChar)
        }
    }
    
    @IBAction func charactersSlider(_ sender: UISlider) {
        
        numberOfChar = Int(sender.value)
        numberCharTextField.text = String(numberOfChar)
        passwordTextField.text = generateRandomString(numberOfCharacters: numberOfChar)
    }
    
    @IBAction func generateNewPassword(_ sender: Any) {
        passwordTextField.text = generateRandomString(numberOfCharacters: numberOfChar)
    }
    
    @IBAction func copyButton(_ sender: UIButton) {
        
        copyButton.isEnabled = false
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: Selector(("enablefunc")), userInfo: nil, repeats: false)
        
        UIPasteboard.general.string = passwordTextField.text
        copyButton.backgroundColor = UIColor.darkGray
        
        UIView.animate(withDuration: 2, delay: 0.5, options: [.allowUserInteraction], animations: {
            self.copyButton.setTitle("Copied!", for: UIControl.State.normal)
            self.copyButton.backgroundColor = self.green
        }, completion: { _ in
            self.copyButton.setTitle("Copy", for: UIControl.State.normal)
        })
    }
    
    @objc func enablefunc() {
        copyButton.isEnabled = true
    }
    
    func generateRandomString(numberOfCharacters: Int) -> String {
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
