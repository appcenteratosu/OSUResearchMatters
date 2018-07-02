//
//  Event.swift
//  CSVParsing
//
//  Created by osuappcenter on 9/2/17.
//  Copyright © 2017 Russell Davis App Developement. All rights reserved.
//

import Foundation
import UIKit

/// Events are structed from headers from CSV file
public class Event {
    
    // Change this class to represent the data that will be recieved from the URLSessionDataTask
    
    public var subject: String = ""
    public var sDate: String = ""
    public var sTime: String = ""
    public var eDate: String = ""
    public var eTime: String = ""
    public var allDayEvent: String = ""
    public var desc: String = ""
    public var location: String = ""
    public var link: String = ""
    public var template: String = ""
    public var audience: String = ""
    public var building: String = ""
    public var campus: String = ""
    public var category: String = ""
    public var contactEmail: String = ""
    public var contactName: String = ""
    public var contactPhone: String = ""
    public var cost: String = ""
    public var eventImage: String = ""
    public var room: String = ""
    public var Sponsor: String = ""
    public var eventType: String = ""
    
    // Used as utility
    var sortDate: Date?
    var viewColor: UIColor?
    var duration: DateInterval?
    
    init() {
        
    }
    
    public convenience init(row: [String]) {
        self.init()
        
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
        self.campus = row[11]
        self.category = row[12]
        self.contactEmail = row[13]
        self.contactName = row[14]
        self.contactPhone = row[15]
        self.cost = row[16]
        self.eventImage = row[17]
        self.room = row[16]
        self.Sponsor = row[17]
        self.eventType = row[18]
        
        // Utility setup
        
        if let date = Utilities().toDate(str: sDate) {
            self.sortDate = date
        } else {
            print("Could not parse string to date for Event Object (Event INIT)")
        }
        
        self.viewColor = ColorCode().getSponsorColor(sponsor: self.Sponsor)
        
        let start = Utilities().toDate(strDate: sDate, withTime: sTime)!
        let end = Utilities().toDate(strDate: eDate, withTime: eTime)!
        self.duration = DateInterval(start: start, end: end)
        
    }

    convenience init(event: [String: String]) {
        self.init()
        
        for item in event {
            switch item.key {
            case "Subject":
                self.subject = item.value
            case "Start Date":
                self.sDate = item.value
            case "Start Time":
                self.sTime = item.value
            case "End Date":
                self.eDate = item.value
            case "End Time":
                self.eTime = item.value
            case "All day event":
                self.allDayEvent = item.value
            case "Description":
                self.desc = item.value
            case "Location":
                self.location = item.value
            case "Web Link":
                self.link = item.value
            case "Event Template":
                self.template = item.value
            case "Audience":
                self.audience = item.value
            case "Building":
                self.building = item.value
            case "Campus":
                self.campus = item.value
            case "Category":
                self.category = item.value
            case "Contact Email":
                self.contactEmail = item.value
            case "Contact Name":
                self.contactName = item.value
            case "Contact Phone":
                self.contactPhone = item.value
            case "Cost":
                self.cost = item.value
            case "Event image":
                self.eventImage = item.value
            case "Room":
                self.room = item.value
            case "Sponsor":
                self.Sponsor = item.value
            case "Type of Event":
                self.eventType = item.value
            default:
                print("ERROR Creating Event")
            }
        }
    
        // Utility setup
        
        if let date = Utilities().toDate(str: sDate) {
            self.sortDate = date
        } else {
            print("Could not parse string to date for Event Object (Event INIT)")
        }
        
        self.viewColor = ColorCode().getSponsorColor(sponsor: self.Sponsor)
        
        let start = Utilities().toDate(strDate: sDate, withTime: sTime)!
        let end = Utilities().toDate(strDate: eDate, withTime: eTime)!
        self.duration = DateInterval(start: start, end: end)
    
    }

}

extension String {
    func contains(find: String) -> Bool {
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool {
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}

extension Event {
    func contains(searchItems: [String]) -> Bool {
        for item in searchItems {
            if self.subject.containsIgnoringCase(find: item) {
                return true
            } else if self.desc.containsIgnoringCase(find: item) {
                return true
            } else if self.category.containsIgnoringCase(find: item) {
                return true
            } else {
                return false
            }
        }
        return false
    }
}
