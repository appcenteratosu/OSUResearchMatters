//
//  ResearchWeekViewController.swift
//  OSUResearchMatters
//
//  Created by App Center on 1/8/18.
//  Copyright © 2018 Oklahoma State University. All rights reserved.
//

import UIKit

class ResearchWeekViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        getEventsFromServer { (dates, events) in
            self.datesForTable = dates
            self.eventsForTable = events
            
            DispatchQueue.main.async {
                self.dayTableView.reloadData()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Datagrab
    
    typealias completion = ([Date], [[Event]]) -> ()
    func getEventsFromServer(completion: @escaping completion) {
        let manager = CSVDataManager()
        manager.formatDataForNewEventObject(url: "https://www.trumba.com/calendars/okstate-research-week.csv") { (events) in
            print("Completed Calendar Data Fetch (CalendarTVC)")
            print("* Starting Data Sort (CalendarTVC)")
            self.sortEventsByDate(eventsToSort: events, completion: { (sortedEvents) in
                var dates: [Date] = []
                var events: [[Event]] = []
                for eventSet in sortedEvents {
                    let date = eventSet.key
                    dates.append(date)
                    
                    events.append(eventSet.value)
                }
                completion(dates, events)
            })
        }
    }
    
    func sortEventsByDate(eventsToSort: [Event], completion: ([(key: Date, value: [Event])]) -> ()) {
        var dates: [Date: [Event]] = [:]
        for event in eventsToSort {
            if let date = event.sortDate {
                if dates.keys.contains(date) {
                    dates[date]!.append(event)
                } else {
                    dates[date] = [event]
                }
            }
        }
        let sortedDates = dates.sorted { (a, b) -> Bool in
            return a.key < b.key
        }
        completion(sortedDates)
    }
    
    
    
    
    //MARK: - TableView
    
    var datesForTable: [Date] = []
    var eventsForTable: [[Event]] = []
    
    @IBOutlet weak var dayTableView: UITableView!
    @IBOutlet weak var eventsTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == dayTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "day", for: indexPath) as! RWDayTableViewCell
            
            let date = datesForTable[indexPath.row]
            let day = Day(date: date)
            
            cell.dayOfMonth.text = day.dayInMonth
            cell.monthYear.text = day.monthYear
            cell.weekDay.text = day.dayOfWeek
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "event", for: indexPath)
            
            
            return cell
        }
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Change values in datasource
        //Reload Table
    }
    
    
    
    

}
