//
//  CalendarDetailTableViewCell.swift
//  OSUResearchMatters
//
//  Created by App Center on 1/2/18.
//  Copyright © 2018 Oklahoma State University. All rights reserved.
//

import UIKit

class CalendarDetailTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemValueLabel: UILabel!
    
}
