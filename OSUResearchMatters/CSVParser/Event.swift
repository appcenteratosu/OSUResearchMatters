//
//  Event.swift
//  CSVParsing
//
//  Created by osuappcenter on 9/2/17.
//  Copyright © 2017 Russell Davis App Developement. All rights reserved.
//

import Foundation

/// Events are structed from headers from CSV file
public class Event {
    
    // Change this class to represent the data that will be recieved from the URLSessionDataTask
    
    public let subject: String
    public let sDate: String
    public let sTime: String
    public let eDate: String
    public let  eTime: String
    public let  allDayEvent: String
    public let  desc: String
    public let  location: String
    public let  link: String
    public let  template: String
    public let  audience: String
    public let  building: String
    public let  campus: String
    public let  category: String
    public let  contactEmail: String
    public let  contactName: String
    public let  Sponsor: String
    public let  eventType: String
    
    public init(row: [String]) {
        self.subject = row[0]
        self.sDate = row[1]
        self.sTime = row[2]
        self.eDate = row[3]
        self.eTime = row[4]
        self.allDayEvent = row[5]
        if row[6].contains("&nbsp;") {
            let newDesc = row[6].replacingOccurrences(of: "&nbsp;", with: "")
            self.desc = newDesc
        } else {
            self.desc = row[6]
        }
        self.location = row[7]
        self.link = row[8]
        self.template = row[9]
        self.audience = row[10]
        self.building = row[11]
        self.campus = row[12]
        self.category = row[13]
        self.contactEmail = row[14]
        self.contactName = row[15]
        self.Sponsor = row[16]
        self.eventType = row[17]
    }
    
    
    
    
}
