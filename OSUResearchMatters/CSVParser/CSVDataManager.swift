//
//  CSVDataManager.swift
//  CSVParsing
//
//  Created by osuappcenter on 9/2/17.
//  Copyright © 2017 Russell Davis App Developement. All rights reserved.
//

import Foundation
import UIKit

/// The CSV Data Manager is primarily reponsible for providing functionality for formatting fetched data into Event objects
public class CSVDataManager {
 
    public init() {
    }
    
    /// Hands back an array of Events
    public typealias EventHandler = ([Event]) -> ()
    /// Formats fetched data and creates an array of Event objects
    ///
    /// - Parameters:
    ///   - url: String URL to be validated and used as the source for the CSV file
    ///   - completion: Hands back an array of Events
    public func formatDataForNewEventObject(url: String, completion: @escaping EventHandler)  {
        let dataManager = DataDownloader()
        dataManager.beginDataFetchwith(urlString: url) { (data, error) in
            if error != nil {
                switch error! {
                case DataDownloader.DataError.URLInvalid:
                    print("URL is not valid")
                case DataDownloader.DataError.DataIsNil:
                    print("No data for the given URL")
                default:
                    print(error!.localizedDescription)
                }
            } else {
                // Format the data
                let dataString = String(data: data!, encoding: .utf8)
                let parser = CSwiftV(with: dataString!)
                guard let keyedEvents = parser.keyedRows else { return }
                
                var events: [[String: String]] = [[:]]
                let processor = CSVRowProcessor()
                for eventKey in keyedEvents {
                    let event = processor.checkForChanges(dic: eventKey)
                    events.append(event)
                }
                
                let useable = self.findDuplicates(events: events)
                
                var preparedEvents: [Event] = []
                for event in useable {
                    if event.count > 0 {
                        let newEvent = Event(event: event)
                        preparedEvents.append(newEvent)
                    }
                }
                
                
                
                completion(preparedEvents)
            }
        }
    }
    
    func findDuplicates(events: [[String: String]]) -> [[String: String]] {
        var store: [String] = []
        
        for event in events {
            if event.count > 0 {
                let subject = event["Subject"]
                
                if store.contains(subject!) {
                    print("Found duplicate")
                } else {
                    store.append(subject!)
                }
            }
        }
        
        var eventsForUse: [[String: String]] = [[:]]
        for item in store {
            let event = events.first(where: { (dict) -> Bool in
                return dict["Subject"] == item
            })
            
            eventsForUse.append(event!)
        }
        
        return eventsForUse
    }
    
    
}

struct CSVRowProcessor {
    private func switchKey<T, U>(myDict: inout [T:U], fromKey: T, toKey: T) {
        if let entry = myDict.removeValue(forKey: fromKey) {
            myDict[toKey] = entry
        }
    }
    
    func checkForChanges(dic: [String: String]) -> [String: String] {
        var dict = dic
        for item in dict {
            if item.key.contains("(") && item.key.contains(")") {
                let proper = item.key.components(separatedBy: "(").first!
                switchKey(myDict: &dict, fromKey: item.key, toKey: proper)
            }
            
            //test
            if item.value.contains(find: "\"") {
                let proper = item.value.replacingOccurrences(of: "\"", with: "")
                dict[item.key] = proper
            }
            
        }
        
        return dict
    }
}

