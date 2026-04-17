//
//  LoginState.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-17.
//

import Foundation

enum LoginState {
    case notLoggedIn
    case loading
    case loginSuccess
    case error(message: String)
}
