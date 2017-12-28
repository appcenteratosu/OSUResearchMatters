//
//  DayTableViewCell.swift
//  OSUResearchMatters
//
//  Created by App Center on 12/27/17.
//  Copyright © 2017 Oklahoma State University. All rights reserved.
//

import UIKit

class DayTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventsTableView.delegate = self
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
        
        cell.timeLabel.text = events[indexPath.row].sTime
        cell.descriptionLabel.text = events[indexPath.row].desc
        
        return cell
    }

}

