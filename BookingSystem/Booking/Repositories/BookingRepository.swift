//
//  BookingRepository.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-20.
//

import Foundation
import FirebaseFirestore

class BookingRepository {
    
    private var db = Firestore.firestore()


    private func mapToTimeSlot(from doc: QueryDocumentSnapshot) -> TimeSlot? {
        let data = doc.data()
        guard
            let start = (data["start"] as? Timestamp)?.dateValue(),
            let end = (data["end"] as? Timestamp)?.dateValue(),
            let createdBy = data["createdBy"] as? String,
            let capacity = data["capacity"] as? Int,
            let isBooked = data["isBooked"] as? Bool
        else { return nil }
        
        return TimeSlot(
            id: doc.documentID,
            start: start,
            end: end,
            createdBy: createdBy,
            capacity: capacity,
            isBooked: isBooked,
            bookedBy: data["bookedBy"] as? String,
            bookedByName: data["bookedByName"] as? String,
            bookedByEmail: data["bookedByEmail"] as? String,
            notes: data["notes"] as? String
        )
    }
    
    
    
    func fetchAllSlots(for date: Date) async throws -> [TimeSlot] {
        let start = Calendar.current.startOfDay(for: date)
        let end = start.addingTimeInterval(86400)
        
        let snapshot = try await db.collection("timeslots")
            .whereField("start", isGreaterThan: start)
            .whereField("start", isLessThan: end)
            .getDocuments()
        
        return snapshot.documents.compactMap { mapToTimeSlot(from: $0) }
    }

    func fetchAvailableSlots(for date: Date) async throws -> [TimeSlot] {
        let start = Calendar.current.startOfDay(for: date)
        let end = start.addingTimeInterval(86400)
        
        let snapshot = try await db.collection("timeslots")
            .whereField("start", isGreaterThan: start)
            .whereField("start", isLessThan: end)
            .whereField("isBooked", isEqualTo: false)
            .getDocuments()
        
        return snapshot.documents.compactMap { mapToTimeSlot(from: $0) }
    }
    
    func fetchAvailableDates(for month: Date) async throws -> [TimeSlot] {
        let start = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: month))!
        let end = Calendar.current.date(byAdding: .month, value: 1, to: start)!
        
        let snapshot = try await db.collection("timeslots")
            .whereField("start", isGreaterThan: start)
            .whereField("start", isLessThan: end)
            .whereField("isBooked", isEqualTo: false)
            .getDocuments()
        
        return snapshot.documents.compactMap { mapToTimeSlot(from: $0) }
    }
    
    
    func fetchMyBookings(userId: String) async throws -> [TimeSlot] {
        let snapshot = try await db.collection("timeslots")
            .whereField("bookedBy", isEqualTo: userId)
            .getDocuments()
        
        return snapshot.documents.compactMap { mapToTimeSlot(from: $0) }
    }
    
    func bookSlot(slotId: String, userId: String, name: String, email: String, notes: String) async throws {
        try await db.collection("timeslots")
            .document(slotId)
        .updateData([
            "isBooked": true,
            "bookedBy": userId,
            "bookedByName": name,
            "bookedByEmail": email,
            "notes": notes
        ])
    }
    
    func saveBookingToUser(userId: String, slotId: String) async throws {
        try await db.collection("users")
            .document(userId)
            .collection("bookings")
            .document(slotId)
            .setData([
                "slotId": slotId,
                "bookedAt": Date()
            ])
    }
    
    func cancelBooking(slotId: String, userId: String) async throws {
        try await db.collection("timeslots")
            .document(slotId)
            .updateData([
                "isBooked": false,
                "bookedBy": "",
                "bookedByName": "",
                "bookedByEmail": "",
                "notes": ""
            ])
        
        try await db.collection("users")
            .document(userId)
            .collection("bookings")
            .document(slotId)
            .delete()
    }
    
    

}
