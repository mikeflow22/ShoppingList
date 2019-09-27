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
        let  isLongSort = NSSortDescriptor(key: "isLongList" , ascending: true)
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [isLongSort , nameSort]
        let resultsFetched  = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.mainContext, sectionNameKeyPath: "isLongList", cacheName: nil)
        
        do {
            try resultsFetched.performFetch()
        } catch  {
            print("Error  trying to fetch results: \(error)")
        }
        
        fetchedResultsController =  resultsFetched
    }
    
    func createList(name: String) {
        let newList = List(name: name)
        checkItemsIn(list: newList)
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
    
    func checkItemsIn(list: List) {
        guard let itemCount = list.items?.count else  {
            print("Error  unwrapping in checkItems  function")
            return  }
        switch itemCount {
        case 0...3:
            list.isLongList = false
        case 4...1000:
            list.isLongList = true
        default:
            print("the list is toooooo big")
        }
//        return list.items?.count >= 3 ? true : false
//
//        if let listItems = list.items?.count {
//
//        }
//        return listItems.count >= 3 ? true : false
    }
    
    func saveToPersistentStore(){
        do {
            try CoreDataStack.mainContext.save()
        } catch  {
            print("Error saving to persistent store: \(error) in \(#function)")
        }
    }
    
}
