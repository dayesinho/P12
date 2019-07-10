//
//  PasswordViewController.swift
//  PwLocker
//
//  Created by Tavares on 26/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit

class GeneratorViewController: UIViewController, BEMCheckBoxDelegate {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lettersBox.delegate = self
        numbersBox.delegate = self
        specialCharBox.delegate = self
        charactersArray = [letters , numbers , specialChar]
        passwordTextField.text = generateRandomString(numberOfCharacters: numberOfChar)
    }

    func getOneCheckBoxMinimum() {
        
        switch lettersBox.on == true {
        case true:
            numbersBox.isEnabled = true
            specialCharBox.isEnabled = true
        default:
            specialCharBox.isEnabled = false
        }

        switch numbersBox.on == true {
        case true:
            lettersBox.isEnabled = true
            specialCharBox.isEnabled = true
        default:
            lettersBox.isEnabled = false
        }

        switch specialCharBox.on == true {
        case true:
            lettersBox.isEnabled = true
            numbersBox.isEnabled = true
        default:
          numbersBox.isEnabled = false
        }
    }
    
     func didTap(_ checkBox: BEMCheckBox) {
        
        getOneCheckBoxMinimum()
        
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
        UIPasteboard.general.string = passwordTextField.text
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
