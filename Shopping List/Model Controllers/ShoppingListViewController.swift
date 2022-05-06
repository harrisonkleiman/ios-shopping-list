//
//  ShoppingListViewController.swift
//  Shopping List
//
//  Created by Harrison Kleiman on 5/6/22.
//

import UIKit

// MARK: - VC class declaration
class ShoppingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Connected table view
    @IBOutlet weak var shoppingTableView: UITableView!
    // Connected new item text field
    @IBOutlet weak var newItemTextField: UITextField!
    
    // Items will be an array of class Item
    var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        shoppingTableView.delegate = self
        shoppingTableView.dataSource = self
        
        let item1 = Item(name: "Oat milk")
        let item2 = Item(name: "Cereal")
        
        items = [item1, item2]
        
        loadData()
    }
    
    // MARK: - Returns number of rows we will have in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count // counts items in the item list
    }
    
    // MARK: - Creates cell for UI table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        let currentItem = items[indexPath.row]
        cell.textLabel?.text = currentItem.name
        cell.selectionStyle = .none

        return cell
    }
    
    // MARK: - Checkmark on cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
    }
    
    // MARK: - Connected add btn action
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // If there is info in text field...
        if let newItemName = newItemTextField.text {
            
            let newItem = Item(name: newItemName)
            newItemTextField.text = "" // clears text field
            items.append(newItem)
            shoppingTableView.reloadData() // if info is found, load item onto table view
            
            saveData()
        }
    }
    
    // MARK: - Populate (load) data - call in
    func loadData() {
        
        if let objects = UserDefaults.standard.value(forKey: "Items") as? Data {
            
            if let objectsDecoded = try? JSONDecoder().decode(Array.self, from: objects) as [Item] {
                items = objectsDecoded
            }
        }
    }
    
    // MARK: - Save data list does not disapear
    func saveData() {
        
        if let encoded = try? JSONEncoder().encode(items) {
            // Will get error initially, our JSON "items" are not initially "encodable"
            UserDefaults.standard.set(encoded, forKey: "Items")
        }
    }
    
    //MARK: - Delete Items from table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            items.remove(at: indexPath.row)
            shoppingTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

