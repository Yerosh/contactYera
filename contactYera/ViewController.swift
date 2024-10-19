//
//  ViewController.swift
//  contactYera
//
//  Created by Yernur Adilbek on 10/18/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var nameInput: UITextField!
    @IBOutlet private weak var surnameInput: UITextField!
    @IBOutlet private weak var phoneInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func addContact(_ sender: UIButton) {
        let name = nameInput.text!
        let surname = surnameInput.text!
        let phone = phoneInput.text!
        
        let newPerson = Person(name: name, surname: surname, phone: phone)
        
        do {
            if let data = UserDefaults.standard.data(forKey: "personArray") {
                var array = try JSONDecoder().decode([Person].self, from: data)
                array.append(newPerson)
                
                let encoded = try JSONEncoder().encode(array)
                UserDefaults.standard.set(encoded, forKey: "personArray")
                
            } else {
                let encoded = try JSONEncoder().encode([newPerson])
                UserDefaults.standard.setValue(encoded, forKey: "personArray")
            }
            
            let alert = UIAlertController(title: "Success", message: "Contact added successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
        } catch {
            print("Unable to encode \(error)")
        }
        
        
        nameInput.text = ""
        surnameInput.text = ""
        phoneInput.text = ""
    }
}

