//
//  CoreDataStack.swift
//  ShoppingList
//
//  Created by Michael Flowers on 9/27/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation
//step 1
import CoreData

class CoreDataStack {

    
    //step 2: create a static container to hold the stack
    static let container: NSPersistentContainer = {
        //create this container to be run later, when someone asks for it instead of immediately
        let container = NSPersistentContainer(name: "ShoppingList")
        //step 3 tell the container what to do
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //step 4 create a static context (MOC)
   static var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
}
