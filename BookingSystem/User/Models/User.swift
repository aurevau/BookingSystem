//
//  User.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-17.
//

import Foundation

struct User: Identifiable, Codable {
    var id : String
    let accountNumber: Int
    let userRole: UserRole
    let name: String
    let email: String
    let joined: TimeInterval
}
