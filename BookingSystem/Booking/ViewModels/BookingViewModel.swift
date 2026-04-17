//
//  BookingViewModel.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-17.
//

import Observation
import Foundation

@Observable
class BookingViewModel {
    var selectedMonth: Int = 0
    var selectedDate: Date {
        fetchSelectedMonth()
    }
    let days = ["SÖN", "MÅN", "TIS", "ONS", "TOR", "FRE", "LÖR"]
    func fetchDates() -> [CalendarDate] {
        let calendar = Calendar.current
        let currentMonth = fetchSelectedMonth()
        
        
        var dates =
        currentMonth.datesOfMonth().map { date in
            CalendarDate(day: calendar.component(.day, from: date), date: date)
        }
        
        let firstDayOfWeek = calendar.component(.weekday, from: dates.first?.date ?? Date())
        
        for _ in 0..<firstDayOfWeek - 1 {
            dates.insert(CalendarDate(day: -1, date: Date()), at: 0)
        }
        return dates
    }
    
    private func fetchSelectedMonth() -> Date {
        let calendar = Calendar.current
        
        let month = calendar.date(byAdding: .month, value: selectedMonth, to: Date())
        
        return month!
    }
}
