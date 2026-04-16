//
//  RegisterViewModel.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-16.
//

import Observation
import FirebaseAuth

@Observable
class RegisterViewModel {
    var name = ""
    var email = ""
    var password = ""
    var confirmPassword = ""
    var errorMessage = ""
    
    private let authRepository = AuthRepository()
    
    func register() {
        guard validate() else {
            return
        }
        
        Task {
            do {
                let result = try await authRepository.register(email: email, password: password)
                let userId = result.user.uid
                
                // save user to firestore
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty, !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty, !confirmPassword.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errorMessage = "Please fill in all fields."
            return false
        }
        
        guard password.count >= 6 else {
            errorMessage = "Please enter a password of min 6 characters."
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email."
            return false
        }
        
        guard password == confirmPassword else {
            errorMessage = "Password is not matching."
            return false
        }
        
        return true
    }
    
}
