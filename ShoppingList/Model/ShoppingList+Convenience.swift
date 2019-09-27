//
//  ShoppingList+Convenience.swift
//  ShoppingList
//
//  Created by Michael Flowers on 9/27/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation
import CoreData

extension List {
    convenience init(name: String, items: [Item] = [], isLongList: Bool = false, context: NSManagedObjectContext = CoreDataStack.mainContext) {
        self.init(context: context)
        self.name = name
    }
}
