//
//  ListTableViewController.swift
//  ShoppingList
//
//  Created by Michael Flowers on 9/27/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ListController.shared.fetchedResultsController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func addListButtonPressed(_ sender: UIBarButtonItem) {
        //call the  alert Controller function here
        alert()
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
//            tableView.deleteRows(at: [indexPath], with: .fade)
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

extension ListTableViewController {
    func alert(){
        var listTextField: UITextField!
        let alert = UIAlertController(title: "Add List", message: "Please name the list", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "List Name"
            textField.keyboardType = .alphabet
            listTextField = textField
        }
        
        let addAction =  UIAlertAction(title: "ADD", style: .default) { (_) in
            guard let name = listTextField.text, !name.isEmpty else { return }
            ListController.shared.createList(name: name)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            // do we have to add anything here?
        }
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

extension ListTableViewController: NSFetchedResultsControllerDelegate {
    //will tell the tableViewController get ready to do something.
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            //there was a new entry so now we need to make a new cell.
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .move:
            guard let indexPath = indexPath, let newIndexpath = newIndexPath else {return}
            tableView.moveRow(at: indexPath, to: newIndexpath)
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
        
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            let indexSet = IndexSet(integer: sectionIndex)
            tableView.insertSections(indexSet, with: .automatic)
        case .delete:
            let indexSSet = IndexSet(integer: sectionIndex)
            tableView.deleteSections(indexSSet, with: .automatic)
        default:
            break
        }
    }
}
