//
//  TableViewController.swift
//  contactYera
//
//  Created by Yernur Adilbek on 10/18/24.
//

import UIKit

class TableViewController: UITableViewController {
    
    var personArray: [Person] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            if let data = UserDefaults.standard.data(forKey: "personArray") {
                let array = try JSONDecoder().decode([Person].self, from: data)
                
                personArray = array
                
                tableView.reloadData()
            }
        } catch {
            print("Unable to encode TEST \(error)")
        }
    }
    
    func saveTasks() {
        do {
            let encoded = try JSONEncoder().encode(personArray)
            UserDefaults.standard.set(encoded, forKey: "personArray")
        } catch {
            print("Unable to encode \(error)")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return personArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")

//         Configure the cell...
        cell.textLabel?.text = (personArray[indexPath.row].name) + " " + (personArray[indexPath.row].surname)
        
        cell.detailTextLabel?.text = personArray[indexPath.row].phone
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PersonViewController") as! PersonViewController
        
        vc.person = personArray[indexPath.row]
        vc.personArray = personArray
        vc.index = indexPath.row
        
        navigationController?.show(vc, sender: self)
    }
     
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            personArray.remove(at: indexPath.row)
            
            saveTasks()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
