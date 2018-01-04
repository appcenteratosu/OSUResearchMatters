//
//  DayTableViewCell.swift
//  OSUResearchMatters
//
//  Created by App Center on 12/27/17.
//  Copyright © 2017 Oklahoma State University. All rights reserved.
//

import UIKit
import SnapKit
import Foundation

class DayTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    var dsDelegate: DidSelectRowDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventsTableView.delegate = self
        setupBackgroundView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var events: [Event]! {
        didSet {
            eventsTableView.dataSource = self
            DispatchQueue.main.async {
                self.eventsTableView.reloadData()
            }
        }
    }
    
    func setupBackgroundView() {
//        backgroundUIView.snp.makeConstraints { (make) in
//            make.height.equalTo(self.frame.height)
//        }
//        dayOfWeekLabel.snp.makeConstraints { (make) in
//            make.left.equalTo(backgroundUIView)
//        }
    }
    
    @IBOutlet weak var backgroundUIView: UIView!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var calendarDayLabel: UILabel!
    @IBOutlet weak var monthYearLabel: UILabel!
    
    @IBOutlet weak var eventsTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventsTableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventsTableViewCell
        if events.count == 1 {
            cell.descriptionLabel.numberOfLines = 4
        }
        
        if events[indexPath.row].allDayEvent == "TRUE" {
            cell.timeLabel.text = "All Day"
        } else {
            let time = events[indexPath.row].sTime
            let date = Utilities().toDate(strDate: events[indexPath.row].sDate, withTime: time)
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            let ttime = formatter.string(from: date!)
            cell.timeLabel.text = ttime
        }
        cell.descriptionLabel.text = events[indexPath.row].subject
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = events[indexPath.row]
        dsDelegate?.eventWasSeleted(event: event)
        print(event.subject)
    }

    
}

protocol DidSelectRowDelegate {
    func eventWasSeleted(event: Event)
}
