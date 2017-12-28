//
//  CSVDataManager.swift
//  CSVParsing
//
//  Created by osuappcenter on 9/2/17.
//  Copyright © 2017 Russell Davis App Developement. All rights reserved.
//

import Foundation


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
        dataManager.beginDataFetch(with: url) { (data, error) in
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
                let rows = parser.rows
                
                var events: [Event] = []
                
                for row in rows {
                    let event = Event(row: row)
                    events.append(event)
                }
                // Formatted Events
                completion(events)
            }
        }
    }
    
    
}
