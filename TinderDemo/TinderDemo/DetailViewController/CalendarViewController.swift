//
//  CalendarViewController.swift
//  TinderDemo
//
//  Created by macOS on 9/17/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import Foundation
import KDCalendar

class CalendarViewController: DetailBaseController {
    @IBOutlet weak var calendarView: CalendarView!
    
    override func viewDidLoad() {
        calendarView.dataSource = self
        guard let isoDate = userModel.dob else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from:isoDate)!
        calendarView.selectDate(date)
        calendarView.setDisplayDate(date)
        calendarView.multipleSelectionEnable = false
        
    }
    
}

extension CalendarViewController:CalendarViewDataSource {
    func headerString(_ date: Date) -> String? {
        guard let isoDate = userModel.dob else { return "Calendar" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from:isoDate)!
        let month = Calendar.current.component(.month, from: date)
        let year = Calendar.current.component(.year, from: date)
        return "\(month)/\(year)"
    }
    
    func startDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = -100
        let today = Date()
        let startDate = self.calendarView.calendar.date(byAdding: dateComponents, to: today)
        return startDate ?? today
    }
    
    func endDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = 3
        let today = Date()
        let endDate = self.calendarView.calendar.date(byAdding: dateComponents, to: today)
        return endDate ?? today
    }
}
