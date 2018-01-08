//
//  Contact.swift
//  OSUResearchMatters
//
//  Created by App Center on 1/7/18.
//  Copyright © 2018 Oklahoma State University. All rights reserved.
//

import Foundation

class Contact {
    let name: String
    let number: String
    let email: String
    let location: String
    
    init(name: String, number: String, email: String, location: String) {
        self.name = name
        self.number = number
        self.email = email
        self.location = location
    }
}
