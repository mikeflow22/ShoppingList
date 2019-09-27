//
//  ItemController.swift
//  ShoppingList
//
//  Created by Michael Flowers on 9/27/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation
import CoreData

class ItemController {
    
   static func addItemWith(name: String, and list: List){
        let _ = Item(name: name, list: list)
        ListController.shared.saveToPersistentStore()
    }
    
    static func updateItem(item: Item, newName name: String,  isComplete: Bool){
        item.name = name
        item.isComplete = isComplete
         ListController.shared.saveToPersistentStore()
    }
    
    static func toggleItem(_ item: Item){
        item.isComplete = !item.isComplete
         ListController.shared.saveToPersistentStore()
    }
    
    static func remove(item: Item){
        CoreDataStack.mainContext.delete(item)
        ListController.shared.saveToPersistentStore()
    }
}
