//
//  LoginState.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-17.
//

import Foundation

enum LoginState {
    case idle
    case notLoggedIn
    case loginSuccess
    case error(message: String)
}
