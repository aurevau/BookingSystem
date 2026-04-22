//
//  BookingViewModel.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-17.
//

import Observation
import Foundation

@Observable
class CalendarViewModel {
    
    // Might put everything in bookingViewModel to be able to fetch all data connected to bookings for now
    var selectedMonth: Int = 0
    var availableDates: Set<String> = [
    ]
    
    private let repository = BookingRepository()

    
    func fetchAvailableDates(for month: Date) async {
            do {
                let slots = try await repository.fetchAvailableSlots(for: month)
                availableDates = Set(slots.map { $0.start.monthDayYearFormat() })
            } catch {
                print(error.localizedDescription)
            }
        }
        
        func hasAvailableSlots(for date: Date) -> Bool {
            availableDates.contains(date.monthDayYearFormat())
        }
    
    // Gammal kod
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
