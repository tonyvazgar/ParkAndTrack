//
//  TableViewCell.swift
//  UniPark
//
//  Created by Tony Vazgar on 5/17/19.
//  Copyright © 2019 Tony Vazgar. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var latitudLabel: UILabel!
    @IBOutlet weak var longitudLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        latitudLabel.adjustsFontForContentSizeCategory = true
        longitudLabel.adjustsFontForContentSizeCategory = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
