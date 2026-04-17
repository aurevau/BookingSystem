//
//  User.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-17.
//

import Foundation

struct User: Identifiable, Codable {
    var id = UUID().uuidString
    let accountNumber: Int
    let name: String
    let email: String
    let joined: TimeInterval
}
