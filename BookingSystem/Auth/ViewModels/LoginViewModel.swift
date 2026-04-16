//
//  LoginViewModel.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-16.
//

import Observation
import FirebaseAuth

@Observable
class LoginViewModel {
    var email = ""
    var password = ""
    var errorMessage = ""
    
    private let repo = AuthRepository()
    
    func login() {
        guard validate() else {
            return 
        }
        
        Task {
            do {
                let result = try await repo.login(email: email, password: password)
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email."
            return false
        }
        
        return true
        
    }
    
}
