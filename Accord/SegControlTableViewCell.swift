//
//  SegControlTableViewCell.swift
//  Accord
//
//  Created by Leonardo Lee on 10/18/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit

class SegControlTableViewCell: UITableViewCell {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.segmentedControl.setTitle(<#title: String?#>, forSegmentAtIndex: <#Int#>)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
