//
//  RWDayTableViewCell.swift
//  OSUResearchMatters
//
//  Created by App Center on 1/8/18.
//  Copyright © 2018 Oklahoma State University. All rights reserved.
//

import UIKit

class RWDayTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var weekDay: UILabel!
    @IBOutlet weak var dayOfMonth: UILabel!
    @IBOutlet weak var monthYear: UILabel!
    
    
    
    
    
    
    
    

}
