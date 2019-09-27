//
//  ShoppingListController.swift
//  ShoppingList
//
//  Created by Michael Flowers on 9/27/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation
import CoreData

class ListController {
    
    static let shared = ListController()
    var fetchedResultsController: NSFetchedResultsController<List>
    init(){
        //create your fetchResultsController here
        let fetchRequest: NSFetchRequest<List> = List.fetchRequest()
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [nameSort]
        let resultsFetched  = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.mainContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try resultsFetched.performFetch()
        } catch  {
            print("Error  trying to fetch results: \(error)")
        }
        
        fetchedResultsController =  resultsFetched
    }
    
    func createList(name: String) {
        _ = List(name: name)
        saveToPersistentStore()
    }
    
    func delete(list: List){
        CoreDataStack.mainContext.delete(list)
        saveToPersistentStore()
    }
    
    func update(list: List, withName name: String){
        list.name = name
        saveToPersistentStore()
    }
    
    func saveToPersistentStore(){
        do {
            try CoreDataStack.mainContext.save()
        } catch  {
            print("Error saving to persistent store: \(error) in \(#function)")
        }
    }
    
}
