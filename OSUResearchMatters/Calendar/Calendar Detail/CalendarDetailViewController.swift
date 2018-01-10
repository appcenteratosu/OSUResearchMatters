//
//  CalendarDetailViewController.swift
//  OSUResearchMatters
//
//  Created by App Center on 1/2/18.
//  Copyright © 2018 Oklahoma State University. All rights reserved.
//

import UIKit
import EventKit

class CalendarDetailViewController: UITableViewController {
    
    var cellData: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.navigationController?.isNavigationBarHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let titles = ["Title",
                  "Description",
                  "Start Time",
                  "End Time",
                  "Location",
                  "Category",
                  "Contact Name",
                  "Contact Phone",
                  "Contact Email",
                  "Sponsor",
                  "Link"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CalendarDetailTableViewCell
        
        
        let header = titles[indexPath.row]
        cell.itemNameLabel.text = header
        
        switch header {
        case "Title":
            cell.itemValueLabel.text = cellData?.subject
        case "Description":
            if cellData!.desc.count < 1 {
                cell.itemValueLabel.text = "N/A"
            } else {
                cell.itemValueLabel.text = cellData!.desc
            }
        case "Start Time":
            if isAllDay(allDay: cellData!.allDayEvent) {
                let date = Utilities().getFormattedDateFromFormattedString(dateString: cellData!.sDate).string
                let edit = "\(date) (All Day Event)"
                cell.itemValueLabel.text = edit
            } else {
                let stime =  getTime(time: cellData!.sTime, date: cellData!.sDate)
                let sdate = Utilities().getFormattedDateFromFormattedString(dateString: cellData!.sDate).string
                let s = "\(stime) - \(sdate)"
                cell.itemValueLabel.text = s
            }
        case "End Time":
            if isAllDay(allDay: cellData!.allDayEvent) {
                cell.itemValueLabel.text = Utilities().getFormattedDateFromFormattedString(dateString: cellData!.eDate).string
            } else {
                let etime = getTime(time: cellData!.eTime, date: cellData!.eDate)
                let edate = Utilities().getFormattedDateFromFormattedString(dateString: cellData!.eDate).string
                let e = "\(etime) - \(edate)"
                cell.itemValueLabel.text = e
            }
        case "Location":
            if cellData!.location.count < 1 {
                cell.itemValueLabel.text = "N/A"
            } else {
                cell.itemValueLabel.text = cellData!.location
            }
        case "Category":
            if cellData!.category.count < 1 {
                cell.itemValueLabel.text = "N/A"
            } else {
                cell.itemValueLabel.text = cellData!.category
            }
        case "Contact Name":
            if cellData!.contactName.count < 1 {
                cell.itemValueLabel.text = "N/A"
            } else {
                cell.itemValueLabel.text = cellData!.contactName
            }
        case "Contact Phone":
            if cellData!.contactPhone.count < 1 {
                cell.itemValueLabel.text = "N/A"
            } else {
                cell.itemValueLabel.text = cellData!.contactPhone
            }
        case "Contact Email":
            if cellData!.contactEmail.count < 1 {
                cell.itemValueLabel.text = "N/A"
            } else {
                cell.itemValueLabel.text = cellData!.contactEmail
            }
        case "Sponsor":
            if cellData!.Sponsor.count < 1 {
                cell.itemValueLabel.text = "N/A"
            } else {
                cell.itemValueLabel.text = cellData!.Sponsor
            }
        case "Link":
            if cellData!.link.count < 1 {
                cell.itemValueLabel.text = "N/A"
            } else {
                cell.itemValueLabel.text = cellData!.link
            }
        default:
            cell.itemValueLabel.text = ""
        }
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 55
//    }
    
//    // Outlets
//    @IBOutlet weak var titlelabel: UILabel!
//    @IBOutlet weak var descriptionLabel: UILabel!
//    @IBOutlet weak var startTimeLabel: UILabel!
//    @IBOutlet weak var endTimeLabel: UILabel!
//    @IBOutlet weak var locationLabel: UILabel!
//    @IBOutlet weak var categoryLabel: UILabel!
//    @IBOutlet weak var contactName: UILabel!
//    @IBOutlet weak var contactPhone: UILabel!
//    @IBOutlet weak var contactEmail: UILabel!
//    @IBOutlet weak var sponsorLabel: UILabel!
//    @IBOutlet weak var linkLabel: UILabel!
    
//    func setLabels(event: Event) {
//        titlelabel.text = event.subject
//        descriptionLabel.text = event.desc
//        if isAllDay(allDay: event.allDayEvent) {
//            let date = Utilities().getFormattedDate(dateString: event.sDate).string
//            let edit = "\(date) (All Day Event)"
//            startTimeLabel.text = edit
//            endTimeLabel.text = Utilities().getFormattedDate(dateString: event.eDate).string
//        } else {
//            let stime =  getTime(time: event.sTime, date: event.sDate)
//            let sdate = Utilities().getFormattedDate(dateString: event.sDate).string
//            let s = "\(stime), \(sdate)"
//            startTimeLabel.text = s
//
//            let etime = getTime(time: event.eTime, date: event.eDate)
//            let edate = Utilities().getFormattedDate(dateString: event.eDate).string
//            let e = "\(etime), \(edate)"
//            endTimeLabel.text = e
//        }
//        locationLabel.text = event.location
//        categoryLabel.text = event.category
//        contactName.text = event.contactName
//        contactPhone.text = event.contactPhone
//        contactEmail.text = event.contactEmail
//        sponsorLabel.text = event.Sponsor
//        linkLabel.text = event.link
//
//    }
    
    
    
    func getTime(time: String, date: String) -> String {
        let date = Utilities().toDate(strDate: date, withTime: time)
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        let time = formatter.string(from: date!)
        return time
    }
    
    func isAllDay(allDay: String) -> Bool {
        if allDay == "TRUE" {
            return true
        } else {
            return false
        }
    }
    
    
    // Actions
    
    @IBAction func addToCalendar(_ sender: UIBarButtonItem) {
        
        let startD = self.cellData!.sDate
        let startT = self.cellData!.sTime
        let sd = createDateForCalendarEvent(stringDate: startD, stringTime: startT)
        
        let endD = self.cellData!.eDate
        let endT = self.cellData!.eTime
        let ed = createDateForCalendarEvent(stringDate: endD, stringTime: endT)
        
        showCalendarAlert(title: "Add Event to your Calendar?", message: "This will add the event to your default calendar.", startDate: sd, endDate: ed)
    
    }
    
    @IBAction func shareCalendarEvent(_ sender: UIBarButtonItem) {
        let name = cellData!.subject
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        let s = createDateForCalendarEvent(stringDate: cellData!.sDate, stringTime: cellData!.sTime)
        let start = formatter.string(from: s)
        let e = createDateForCalendarEvent(stringDate: cellData!.eDate, stringTime: cellData!.eTime)
        let end = formatter.string(from: e)
        
        let summary: String = """
        \(name)
        
        \(start) - \(end)
        """
        
        let actionSheet = UIActivityViewController(activityItems: [summary], applicationActivities: nil)
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = description
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let e as NSError {
                    completion?(false, e)
                    return
                }
                completion?(true, nil)
            } else {
                completion?(false, error as NSError?)
            }
        })
    }
    
    func createDateForCalendarEvent(stringDate: String, stringTime: String) -> Date {
        let date = Utilities().toDate(strDate: stringDate, withTime: stringTime)
        return date!
    }
    
    func gotoAppleCalendar(date: Date) {
        let interval = date.timeIntervalSinceReferenceDate
        let url = URL(string: "calshow:\(interval)")!
        DispatchQueue.main.async {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func showCalendarAlert(title: String, message: String, startDate: Date, endDate: Date) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (done) in
            self.addEventToCalendar(title: self.cellData!.subject, description: self.cellData!.desc, startDate: startDate, endDate: endDate) { (done, error) in
                                    if error != nil {
                                        print(error!.localizedDescription)
                                    } else {
                                        if done {
                                            print("Done adding event to calendar")
                                            self.gotoAppleCalendar(date: startDate)
                                        }
                                    }
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
    }
    

}
