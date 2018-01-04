//
//  EventsTableViewCell.swift
//  OSUResearchMatters
//
//  Created by App Center on 12/27/17.
//  Copyright © 2017 Oklahoma State University. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var colorCode: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
}
