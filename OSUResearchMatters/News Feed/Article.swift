//
//  Article.swift
//  OSUResearchMatters
//
//  Created by App Center on 12/19/17.
//  Copyright © 2017 Oklahoma State University. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import SWXMLHash

class Article {
    let title: String
    let link: URL
    let date: Date
    let dateString: String
    let description: String
    var imageURL: URL?
    var image: UIImage?
    
    init(title: String, date: String, link: String, description: String) {
        self.title = title
        
        let url = URL(string: link)!
        self.link = url
        
        let date = Utilities().getFormattedDate(dateString: date)
        self.date = date.date
        self.dateString = date.string

        self.description = description
        
    }
    
    
    
    
}

struct Articlee: XMLIndexerDeserializable {
    
    let title: String
    let link: String
    let date: String
    let description: String
    var imageURL: String
    var image: UIImage?
    
    static func deserialize(_ node: XMLIndexer) throws -> Articlee {
        return try Articlee(
            title: node["title"].value(),
            link: node["link"].value(),
            date: node["pubDate"].value(),
            description: node["description"].value(),
            imageURL: node["media:content"]["media:thumbnail"].value(ofAttribute: "url"),
            image: nil
        )
    }
}

