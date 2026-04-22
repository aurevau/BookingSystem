//
//  BookingViewModel.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-19.
//

import Observation
import Foundation

@Observable
class BookingViewModel {
    var name: String = ""
    var email: String = ""
    var notes: String = ""
    
    // DayView
    var selectedDate: Date?
    
    
    // CalendarView
    var selectedMonth: Int = 0
    
    var availableDates: Set<String> = [
    ]
    
    func fetchAvailableDates(for month: Date) async {
            do {
                let slots = try await repository.fetchAvailableDates(for: month)
                availableDates = Set(slots.map { $0.start.monthDayYearFormat() })
            } catch {
                print(error.localizedDescription)
            }
        }
        
        func hasAvailableSlots(for date: Date) -> Bool {
            availableDates.contains(date.monthDayYearFormat())
        }
    
    var slots: [TimeSlot] = []
    var myBookings: [TimeSlot] = []
    var selectedSlot: TimeSlot?
    var errorMessage: String?
    
    private let repository = BookingRepository()
    private let authRepository = AuthRepository()
    
    func getUserId() -> String? {
        authRepository.userId
    }

    func fetchAvailableSlots(for date: Date) async {
        do {
            slots = try await repository.fetchAvailableSlots(for: date)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func fetchAllSlots(for date: Date) async {
        do {
            slots = try await repository.fetchAllSlots(for: date)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func fetchMyBookings(userId: String) async {
        do {
            myBookings = try await repository.fetchMyBookings(userId: userId)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    
    func getMyBooking(for date: Date) -> TimeSlot? {
        myBookings.first { Calendar.current.isDate($0.start, inSameDayAs: date) }
    }
    
    
    
    // Calender info
    var selectedMonthDate: Date {
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
    
    
    
    
    func validateInfo() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Fyll i din email"
            return false
        }
        
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Fyll i ditt namn"
            return false
        }
        
        return true
            
        }
    
    func confirmBooking(slot: TimeSlot?, userId: String?) async {
        
        guard let slot = slot, let userId = userId else {
                errorMessage = "Något gick fel"
                return
            }
        
        guard validateInfo() else {
            return
        }
        
        do {
            try await repository.bookSlot(slotId: slot.id, userId: userId, name: name, email: email, notes: notes)
            
            try await repository.saveBookingToUser(userId: userId, slotId: slot.id)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func cancelBooking(slot: TimeSlot, userId: String) async {
        do {
            try await repository.cancelBooking(slotId: slot.id, userId: userId)
            myBookings.removeAll { $0.id == slot.id }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    
    
}
