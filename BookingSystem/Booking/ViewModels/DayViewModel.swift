//
//  DayViewModel.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-18.
//

import Observation
import Foundation

@Observable
class DayViewModel {
    var dates = [
        Date(),
        Calendar.current.date(byAdding: .hour, value: 1, to: Date()),
        Calendar.current.date(byAdding: .hour, value: 2, to: Date()),
        Calendar.current.date(byAdding: .hour, value: 3, to: Date()),
        Calendar.current.date(byAdding: .hour, value: 4, to: Date())
    ]
    var selectedDate: Date?
}
