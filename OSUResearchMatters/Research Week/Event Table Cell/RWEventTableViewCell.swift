//
//  RWEventTableViewCell.swift
//  OSUResearchMatters
//
//  Created by App Center on 1/9/18.
//  Copyright © 2018 Oklahoma State University. All rights reserved.
//

import UIKit

class RWEventTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var colorCode: UIView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    
    
    
    
    
    
    
}
