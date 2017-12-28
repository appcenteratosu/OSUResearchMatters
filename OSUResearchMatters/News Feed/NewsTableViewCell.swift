//
//  NewsTableViewCell.swift
//  OSUResearchMatters
//
//  Created by App Center on 12/19/17.
//  Copyright © 2017 Oklahoma State University. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    
    
}
