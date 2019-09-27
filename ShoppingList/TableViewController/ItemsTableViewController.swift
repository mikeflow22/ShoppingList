//
//  ItemsTableViewController.swift
//  ShoppingList
//
//  Created by Michael Flowers on 9/27/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {

    var list: List?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = list?.name
    }

    @IBAction func addItemButtonPressed(_ sender: UIBarButtonItem) {
        //call alert controller
        alert()
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list?.items?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCellTableViewCell
        guard let item = list?.items?[indexPath.row] as? Item else {
            print("Error casting items \(#function)")
            return UITableViewCell() }
        cell.item = item
        // Configure the cell...

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let itemToDeleteFromList = list?.items?[indexPath.row] as? Item else {
                print("Error deleting items")
                return }
            ItemController.remove(item: itemToDeleteFromList)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
extension ItemsTableViewController {
    func alert(){
        var listTextField: UITextField!
        let alert = UIAlertController(title: "Add Item", message: "Please enter Item", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Item's Name"
            textField.keyboardType = .alphabet
            listTextField = textField
        }
        
        let addAction =  UIAlertAction(title: "ADD", style: .default) { (_) in
            guard let name = listTextField.text, !name.isEmpty,
                let list = self.list else {print("Error with list in itemTableViewController") ; return }
           ItemController.addItemWith(name: name, and: list)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            // do we have to add anything here?
        }
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

