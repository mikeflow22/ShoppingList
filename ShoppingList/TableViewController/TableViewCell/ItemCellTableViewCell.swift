//
//  ItemCellTableViewCell.swift
//  ShoppingList
//
//  Created by Michael Flowers on 9/27/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit



class ItemCellTableViewCell: UITableViewCell {
    
    var item: Item?

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var checkmarkImage: UIButton!
 
    
    
    @IBAction func checkmarkButtonPressed(_ sender: UIButton) {
    }
    
}
