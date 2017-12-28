//
//  NewsFeedTableViewCell.swift
//  OSUResearchMatters
//
//  Created by App Center on 12/21/17.
//  Copyright © 2017 Oklahoma State University. All rights reserved.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var aTitle: UILabel!
    @IBOutlet weak var aDate: UILabel!
    @IBOutlet weak var aDescription: UILabel!
    @IBOutlet weak var aImage: UIImageView!
    
    var article: Articlee! {
        didSet {
            self.setupUI()
        }
    }
    
    func setupUI() {
        let thumbnailURL = article.imageURL
        let networkService = NetworkService(url: thumbnailURL)
        networkService.downloadImage { (data) in
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.aImage.image = image
                }
            }
        }
    }
    
    

}
