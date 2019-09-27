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
        ItemController.checkItemsIn(list: list)
        ListController.shared.saveToPersistentStore()
    }
    
   static private func checkItemsIn(list: List) {
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
