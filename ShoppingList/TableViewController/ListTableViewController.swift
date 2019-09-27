//
//  ListTableViewController.swift
//  ShoppingList
//
//  Created by Michael Flowers on 9/27/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func addListButtonPressed(_ sender: UIBarButtonItem) {
        
        //call the  alert Controller function here
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ListController.shared.fetchedResultsController.sections?[section].numberOfObjects ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        let list = ListController.shared.fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = list.name
        //STYLE THE TEXTLABEL'S FONT
        
        // Configure the cell...
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //delete from ps
            let listToDelete  = ListController.shared.fetchedResultsController.object(at: indexPath)
            ListController.shared.delete(list: listToDelete)
            
            //do not  need the following because the NSFRC's delegate methods with handle this
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellSegue" {
           guard let destination = segue.destination as? ItemsTableViewController, let indexPath = tableView.indexPathForSelectedRow else { print("Error in the segue"); return }
            let listToPass = ListController.shared.fetchedResultsController.object(at: indexPath)
            destination.list = listToPass
        }
    }
    

}
