//
//  LoginState.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-17.
//

import Foundation

enum RegisterState: Equatable {
    case idle
    case registerFailed
    case registerSuccess
    case error(message: String)
}
