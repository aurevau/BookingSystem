//
//  TimeSlot.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-20.
//

import Foundation

struct TimeSlot: Identifiable, Codable, Hashable {
    let id: String
    var start: Date
    var end: Date
    var createdBy: String
    var capacity: Int
    var isBooked: Bool
    var bookedBy: String?
    var bookedByName: String?
    var bookedByEmail: String?
    var notes: String?
    
}
