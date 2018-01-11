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
        let loading = Utilities.TableViewManager(vc: self)
        loading.setLoadingScreen()
        
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
                loading.removeLoadingScreen()
            }
        }
        
        Utilities.ViewSetup().setupHeader(vc: self)

        tableView.tableFooterView = UIView()

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
        if datesForDataSource.count > 0 {
            return datesForDataSource.count
        } else {
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if datesForDataSource.count > 0 {
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
            
            tableView.separatorStyle = .singleLine
            
            return cell
        } else {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "nodayCell", for: indexPath)
            cell2.textLabel?.text = "No Results"
            
            tableView.separatorStyle = .none
            
            return cell2
        }
        
    }
    
    
    var heightDictionary: [Int: CGFloat] = [:]
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if datesForDataSource.count > 0 {
            return heightDictionary[indexPath.row]!
        } else {
            return 30
        }
    }
    
    
    // MARK: - Views
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
                } else {
                    datesForDataSource = []
                    eventsForDataSource = []
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.endEditing(true)
                    }
                }
            }
        } else {
            showAlert(title: "Oops!", message: "Please enter a search query")
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        
        setEventsToDefault()
    }
    
    
    // MARK: - DidSelectRowDelegate
    func eventWasSeleted(event: Event) {
        performSegue(withIdentifier: "showCalDetail", sender: event)
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
        
        doneButton.layer.cornerRadius = 5
        completion()
    }
    
    @IBOutlet weak var doneButton: UIButton!
    @IBAction func closeLegend(_ sender: UIButton) {
        Utilities.Animation().animateOut(view: legend, vc: self)
    }
    
    func didSelectItemFromLegend(itemColor: UIColor) {
        var eventsToSearch: [Event] = []
        for set in eventsForDataSource {
            eventsToSearch.append(contentsOf: set)
        }
        
        var deptEvents: [Event] = []
        for event in eventsToSearch {
            if event.color == itemColor {
                deptEvents.append(event)
            }
        }
        
        if deptEvents.count > 0 {
            self.sortEventsByDate(eventsToSort: deptEvents, completion: { (sortedEvents) in
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
                    let item = UIBarButtonSystemItem.stop
                    let refresh = UIBarButtonItem(barButtonSystemItem: item,
                                                  target: self,
                                                  action: #selector(self.setEventsToDefault))
                    self.navigationItem.rightBarButtonItem = refresh
                }
            })
        }
        
    }
    
    @objc func setEventsToDefault() {
        getData { (dates, events) in
            self.datesForDataSource = dates
            self.eventsForDataSource = events
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.endEditing(true)
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.bookmarks, target: self, action: #selector(self.resetNavbarItem))
            }
        }
    }
    
    @objc func resetNavbarItem() {
        setupLegend {
            
        }
    }
    
    
    
    // ALERT
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
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
