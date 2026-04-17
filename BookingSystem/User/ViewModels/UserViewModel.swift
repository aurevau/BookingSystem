//
//  UserViewModel.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-17.
//

import Observation
import Foundation

@Observable
class UserViewModel {
    private var userRepo = UserRepository()
    var userRole: UserRole = .guest
    var errorMessage = ""
    
    init() {
            checkRole()
        }

    func checkRole() {
        Task {
            do {
                userRole = try await userRepo.getUserRole()
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
