//
//  PersonViewController.swift
//  contactYera
//
//  Created by Yernur Adilbek on 10/18/24.
//

import UIKit

class PersonViewController: ViewController {
    
    @IBOutlet private weak var editedName: UITextField!
    @IBOutlet private weak var editedSurname: UITextField!
    @IBOutlet private weak var editedPhone: UITextField!
    
    var person = Person(name: "", surname: "", phone: "")
    
    var personArray: [Person] = []
    
    var index = 0
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        editedName.text = person.name
        editedSurname.text = person.surname
        editedPhone.text = person.phone
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do {
            if let data = UserDefaults.standard.data(forKey: "personArray") {
                let array = try JSONDecoder().decode([Person].self, from: data)
                
                personArray = array
            }
        } catch {
            print("Unable to encode TEST \(error)")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func editContact(_ sender: UIButton) {
        personArray[index] = Person(name: editedName.text!, surname: editedSurname.text!, phone: editedPhone.text!)
        
        do {
            let encoded = try JSONEncoder().encode(personArray)
            UserDefaults.standard.set(encoded, forKey: "personArray")
            
            let alert = UIAlertController(title: "Success", message: "Contact edited successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } catch {
            print("Unable to encode \(error)")
        }
    }
}
