//
//  Utilities.swift
//  OSUResearchMatters
//
//  Created by App Center on 12/19/17.
//  Copyright © 2017 Oklahoma State University. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    func getImageFromURL(url: URL, completion: @escaping (UIImage) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error getting image from URL")
            } else {
                if let data = data {
                    let image = UIImage(data: data)
                    completion(image!)
                }
            }
        }
        task.resume()
    }
    
    func getFormattedDate(dateString: String) -> (string: String, date: Date) {
        let ts = dateString.dropLast(9)
        let day = ts.dropFirst(8)
        let m = ts.dropFirst(5)
        let month = m.dropLast(3)
        let year = ts.dropLast(6)
        
        let iDay = Int(String(day))
        let iMonth = Int(String(month))
        let iYear = Int(String(year))
        
        var components = DateComponents()
        components.day = iDay
        components.month = iMonth
        components.year = iYear
        
        let cal = Calendar(identifier: .gregorian)
        let date = cal.date(from: components)
        
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        
        let formattedDate = formatter.string(from: date!)
        
        return (formattedDate, date!)
        
    }
    
    func toDate(str: String) -> Date? {
        let components = str.components(separatedBy: "/")
        guard let month = Int(components[0]) else {return nil}
        guard let day = Int(components[1])  else {return nil}
        guard let year = Int(components[2])  else {return nil}
        
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        
        let date = calendar.date(from: dateComponents)
        
        return date
    }
    
    func toDate(strDate: String, withTime: String) -> Date? {
        let components = strDate.components(separatedBy: "/")
        guard let month = Int(components[0]) else {return nil}
        guard let day = Int(components[1])  else {return nil}
        guard let year = Int(components[2])  else {return nil}
        
        let timeComponents = withTime.components(separatedBy: ":")
        guard let hour = Int(timeComponents[0]) else {return nil}
        guard let minute = Int(timeComponents[1]) else {return nil}
        
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let date = calendar.date(from: dateComponents)
        
        return date
    }

    func getDayOfWeek(date: Date) -> String {
        let weekday = Calendar.current.component(.weekday, from: date)
        print(weekday)
        
        switch weekday {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tues"
        case 4:
            return "Wed"
        case 5:
            return "Thurs"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            return "Error"
        }
    }
    
    func getNumericDay(date: Date) -> String {
        let day = Calendar.current.component(.day, from: date)
        return String(day)
    }
    
    func getFormattedMonthAndYear(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let str = formatter.string(from: date)
        let components = str.components(separatedBy: " ")
        let month = components[0]
        let year = components[2]
        
        let dateyear = "\(month), \(year)"
        return dateyear
    }
    
}
