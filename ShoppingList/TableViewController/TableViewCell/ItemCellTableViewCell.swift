//
//  ItemCellTableViewCell.swift
//  ShoppingList
//
//  Created by Michael Flowers on 9/27/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

protocol ItemCellTableViewCellDelegate: class {
    func  checkmarkValueChanged(cell: UITableViewCell)
}

class ItemCellTableViewCell: UITableViewCell {
    
    weak var delegate: ItemCellTableViewCellDelegate?
    
    var item: Item? {
        didSet {
            print("Item was set in table cell")
            updateViews()
        }
    }

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var checkmarkImage: UIButton!
 
    @IBAction func checkmarkButtonPressed(_ sender: UIButton) {
        delegate?.checkmarkValueChanged(cell: self)
    }
    
    func updateViews(){
        guard let passedInItem = item else { return }
        itemNameLabel.text = passedInItem.name
        let imageName = passedInItem.isComplete ? "complete" : "incomplete"
        checkmarkImage.setImage(UIImage(named: imageName), for: .normal)
    }
    
}
