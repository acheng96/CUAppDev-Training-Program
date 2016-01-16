//
//  TableViewCell.swift
//  Project #5 (CUAppDev)
//
//  Created by Annie Cheng on 1/7/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneImage: UIImageView!
    @IBOutlet weak var emailImage: UIImageView!
    
    // Initialization code
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // Configure the view for the selected state
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

