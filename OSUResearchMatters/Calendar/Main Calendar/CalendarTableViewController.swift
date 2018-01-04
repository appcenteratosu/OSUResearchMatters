//
//  CalendarTableViewController.swift
//  OSUResearchMatters
//
//  Created by App Center on 12/27/17.
//  Copyright © 2017 Oklahoma State University. All rights reserved.
//

import UIKit

class CalendarTableViewController: UITableViewController, DidSelectRowDelegate, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Start Spinner
        CPM().write(text: "Starting Spinner")
        indicator.startAnimating()
        indicator.backgroundColor = #colorLiteral(red: 0.9633523822, green: 0.5470512509, blue: 0.2126187086, alpha: 1)
        
        // Start download of events
        CPM().write(text: "Starting Calendar Data Grab and Sort")
        getData { (dates, events) in
            self.datesForDataSource = dates
            self.eventsForDataSource = events
            // async update UI when completed
            CPM().write(text1: "Done Fetching and Organizing Calendar Data", text2: "Starting Table Reload with Sorted Data")
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                CPM().write(text: "Done reloading table data")
                self.indicator.stopAnimating()
            }
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Hide Nav
//        self.navigationController?.isNavigationBarHidden = true
    }
    
    var datesForDataSource: [Date] = []
    var eventsForDataSource: [[Event]] = []

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData(completion: @escaping ([Date], [[Event]]) -> ()) {
        let manager = CSVDataManager()
        manager.formatDataForNewEventObject(url: "https://trumba.com/calendars/okstate-research.csv") { (events) in
            print("Completed Calendar Data Fetch (CalendarTVC)")
            print("* Starting Data Sort (CalendarTVC)")
            self.sortEventsByDate(eventsToSort: events, completion: { (sortedEvents) in
                var dates: [Date] = []
                var events: [[Event]] = []
                for item in sortedEvents {
                    dates.append(item.key)
                    let eventList = item.value
                    events.append(eventList)
                }
                completion(dates, events)
            })
        }
    }
    
    var events: [Event] = []
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
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datesForDataSource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellItems = eventsForDataSource[indexPath.row]
        let count = CGFloat(cellItems.count)
        if count > 2 {
            heightDictionary[indexPath.row] = count * 45
        } else {
            heightDictionary[indexPath.row] = 100
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as! DayTableViewCell
        cell.events = cellItems
        cell.dsDelegate = self
        
        let day = datesForDataSource[indexPath.row]
        let dayOfWeek = Utilities().getDayOfWeek(date: day)
        let numericDay = Utilities().getNumericDay(date: day)
        let monthYear = Utilities().getFormattedMonthAndYear(date: day)
        
        cell.dayOfWeekLabel.text = dayOfWeek
        cell.calendarDayLabel.text = numericDay
        cell.monthYearLabel.text = monthYear

        return cell
    }
    
    
    var heightDictionary: [Int: CGFloat] = [:]
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightDictionary[indexPath.row]!
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    
    // MARK: Views
    var indicator = UIActivityIndicatorView()
    
    func makeActivityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.activityIndicatorViewStyle = .gray
        indicator.hidesWhenStopped = true
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    // MARK: - Search Functionality
    
    @IBOutlet weak var searchBar: UISearchBar!
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text!.count > 0 {
            if let searchItems = searchBar.text?.components(separatedBy: " ") {
                
                var searchResults: [Event] = []
                
                var eventsToSearch: [Event] = []
                for set in eventsForDataSource {
                    eventsToSearch.append(contentsOf: set)
                }
                
                for event in eventsToSearch {
                    if event.contains(searchItems: searchItems) {
                        searchResults.append(event)
                    }
                }
                
                if searchResults.count > 0 {
                    self.sortEventsByDate(eventsToSort: searchResults, completion: { (sortedEvents) in
                        var dates: [Date] = []
                        var events: [[Event]] = []
                        for item in sortedEvents {
                            dates.append(item.key)
                            let eventList = item.value
                            events.append(eventList)
                        }
                        self.datesForDataSource = dates
                        self.eventsForDataSource = events
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.view.endEditing(true)
                        }
                    })
                }
            }
        } else {
            getData { (dates, events) in
                self.datesForDataSource = dates
                self.eventsForDataSource = events
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.endEditing(true)
                }
            }
        }
    }
    
    
    // MARK: - DidSelectRowDelegate
    func eventWasSeleted(event: Event) {
        performSegue(withIdentifier: "showCalDetail", sender: event)
    }
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCalDetail" {
            if let vc = segue.destination as? CalendarDetailViewController {
                if let event = sender as? Event {
                    vc.cellData = event
                }
            }
        }
    }
    
    @IBAction func returnFromDetail(segue: UIStoryboardSegue) {
    
    }

}
