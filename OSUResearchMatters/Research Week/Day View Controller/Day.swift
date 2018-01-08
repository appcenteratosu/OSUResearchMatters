//
//  Day.swift
//  OSUResearchMatters
//
//  Created by App Center on 1/8/18.
//  Copyright © 2018 Oklahoma State University. All rights reserved.
//

import Foundation

class Day {
    let dayOfWeek: String
    let dayInMonth: String
    let monthYear: String
    
    init(date: Date) {
        let dayOfWeek = Utilities().getDayOfWeek(date: date)
        let dayInMonth = Utilities().getNumericDay(date: date)
        let monthYear = Utilities().getFormattedMonthAndYear(date: date)
        
        self.dayOfWeek = dayOfWeek
        self.dayInMonth = dayInMonth
        self.monthYear = monthYear
    }
    
    
}
