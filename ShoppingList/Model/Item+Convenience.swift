//
//  Item+Convenience.swift
//  ShoppingList
//
//  Created by Michael Flowers on 9/27/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    
    //If we are saying  you  cannot create an item without a shopping list, why give it context default value here? Shouldn't the context be the same as the shoppinglist?
    convenience init(name: String, isComplete: Bool = false, list: List, context: NSManagedObjectContext = CoreDataStack.mainContext) {
        self.init(context: context)
        self.name = name
        self.list = list
    }
}
