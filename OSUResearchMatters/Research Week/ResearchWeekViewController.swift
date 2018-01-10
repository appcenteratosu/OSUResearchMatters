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
        
        setupTableDelegates()
        
        let logo = #imageLiteral(resourceName: "Header-2")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView

        getEventsFromServer { (dates, events) in
            self.datesForTable = dates
            self.eventsForTable = events
            self.events = self.eventsForTable[0]
            
            DispatchQueue.main.async {
                self.dayTableView.reloadData()
                self.eventsTableView.reloadData()
                
                let index = IndexPath(row: 0, section: 0)
                self.dayTableView.selectRow(at: index, animated: true, scrollPosition: .top)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup Items
    func setupTableDelegates() {
        self.dayTableView.delegate = self
        self.dayTableView.dataSource = self
        
        self.eventsTableView.delegate = self
        self.eventsTableView.dataSource = self
        
        self.eventsTableView.estimatedRowHeight = 60
        self.eventsTableView.rowHeight = UITableViewAutomaticDimension
        
        self.eventsTableView.tableFooterView = UIView()
        
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
    var events: [Event] = []
    
    @IBOutlet weak var dayTableView: UITableView!
    @IBOutlet weak var eventsTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == dayTableView {
            return datesForTable.count
        } else {
            return events.count
        }
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "event", for: indexPath) as! RWEventTableViewCell
            
            cell.eventTitle.text = events[indexPath.row].subject
            cell.location.text = events[indexPath.row].location
            
            if events[indexPath.row].allDayEvent == "TRUE" {
                cell.timestamp.text = "All Day Event"
            } else {
                let start = events[indexPath.row].duration.start.Time()
                let end = events[indexPath.row].duration.end.Time()
                
                let time = "\(start) - \(end)"
                cell.timestamp.text = time
            }
            
            cell.colorCode.backgroundColor = events[indexPath.row].color
            cell.colorCode.layer.borderWidth = 1
            cell.colorCode.layer.borderColor = UIColor.darkGray.cgColor
            cell.colorCode.layer.cornerRadius = cell.colorCode.frame.size.height / 2
            
            cell.eventTitle.adjustsFontSizeToFitWidth = true
            
            return cell
        }
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Change values in datasource
        if tableView == dayTableView {
            let events = eventsForTable[indexPath.row]
            self.events.removeAll()
            self.events = events
            
            //Reload Table
            DispatchQueue.main.async {
                self.eventsTableView.reloadData()
            }
        } else {
            let event = events[indexPath.row]
            performSegue(withIdentifier: "showEventDetails", sender: event)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == dayTableView {
            return 114
        } else {
            return 100
        }
    }
    
    
    // MARK: - Legend Key Popup
    
    @IBAction func openLegend(_ sender: UIBarButtonItem) {
        
        setupLegend {
            Utilities.Animation().animateIn(view: legend, vc: self)
        }
        
    }
    
    
    @IBOutlet var legend: UIView!
    
    @IBOutlet var VPR: UIView!
    @IBOutlet var DASNR: UIView!
    @IBOutlet var ArtsSciences: UIView!
    @IBOutlet var Business: UIView!
    @IBOutlet var Education: UIView!
    @IBOutlet var CEAT: UIView!
    @IBOutlet var HumanSciences: UIView!
    @IBOutlet var CVHS: UIView!
    @IBOutlet var GradCollege: UIView!
    @IBOutlet var Library: UIView!
    @IBOutlet var TDC: UIView!
    @IBOutlet var CenterForHealthSciences: UIView!
    @IBOutlet var SpecialPrograms: UIView!
    
    func setupLegend(completion: () -> ()) {
        legend.center = self.view.center
        legend.layer.cornerRadius = 5
        
        let colorCodes = [VPR,DASNR, ArtsSciences,Business,Education,CEAT,HumanSciences,CVHS,GradCollege,Library,TDC,CenterForHealthSciences,SpecialPrograms]
        
        for view in colorCodes {
            view?.layer.cornerRadius = 5
            view?.layer.borderWidth = 2
            view?.layer.borderColor = UIColor.lightGray.cgColor
        }
        completion()
    }
    
    @IBAction func closeLegend(_ sender: UIButton) {
        Utilities.Animation().animateOut(view: legend, vc: self)
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEventDetails" {
            if let vc = segue.destination as? CalendarDetailViewController {
                if let event = sender as? Event {
                    vc.cellData = event
                }
            }
        }
    }
    

}

extension Date {
    func Time() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        let time = formatter.string(from: self)
        return time
    }
}
