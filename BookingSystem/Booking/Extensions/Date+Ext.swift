//
//  Date.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-17.
//

import Foundation

extension Date {
   
    func datesOfMonth() -> [Date] {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: self)
        let currentYear = calendar.component(.year, from: self)
        
        var startDateComponents = DateComponents()
        startDateComponents.year = currentYear
        startDateComponents.month = currentMonth
        startDateComponents.day = 1
        let startDate = calendar.date(from: startDateComponents)!
        
        var endDateComponents = DateComponents()
        endDateComponents.month = 1
        endDateComponents.day = -1
        let endDate = calendar.date(byAdding: endDateComponents, to: startDate)!
        
        var dates: [Date] = []
        var currentDate = startDate
        
        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return dates
    }
    
    // Returns date as ex: April 2026
    func monthYearFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        
        return formatter.string(from: self)
    }
    
    // Returns date as ex: 04/20/23
    func monthDayYearFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }
    
    // Returns date as time 10:10
    func timeFromDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: self)
    }
    
    // Returns dates as ex: April 20, 2026
    func fullMonthDayYearFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM, YYYY"
        return formatter.string(from: self)
    }
    
    // Returns day of the week
    func dayOfTheWeekFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "sv_SE")
        return formatter.string(from: self).capitalized
    }
    
    // Returns a time block of 30 minutes, needs to be refactored?
    func bookingTimeIntervalFormat() -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
    
        
        let start = timeFormatter.string(from: self)
        let endTime = Calendar.current.date(byAdding: .minute, value: 30, to: self)!
        
        let end = timeFormatter.string(from: endTime)
        
        
        
        return "\(start) - \(end)"
    }
    
    
}
