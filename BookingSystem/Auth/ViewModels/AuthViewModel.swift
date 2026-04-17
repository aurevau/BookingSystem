//
//  LoginViewModel.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-16.
//

import Observation
import FirebaseAuth
import Foundation

@Observable
class AuthViewModel {
    var loginState: LoginState = .idle
    var registerState: RegisterState = .idle
    var name = ""
    var email = ""
    var password = ""
    var confirmPassword = ""
    var accountNumber: Int = 0
    var errorMessage = ""
    
    var isLoading: Bool = false
    
    private let repo = AuthRepository()
    private var userRepo = UserRepository()
    
    init() {
        loginState = repo.isSignedIn ? .loginSuccess : .notLoggedIn
    }
    
    func login() {
        guard validate() else {
            return 
        }
        
        Task {
            isLoading = true
            do {
                let result = try await repo.login(email: email, password: password)
                let userId = result.user.uid
                print("\(userId) is logged in")
                loginState = .loginSuccess
                clearLoginFields()
                isLoading = false
            } catch {
                isLoading = false
                errorMessage = error.localizedDescription
                loginState = .error(message: error.localizedDescription)
            }
        }
    }
    
    func logOut() {
        errorMessage = ""
        do {
            try repo.logOut()
            loginState = .notLoggedIn
        } catch {
            errorMessage = "Failed to logout"
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
    
    var isSignedIn: Bool {
        return repo.isSignedIn
    }
    
    func register() {
        guard validateRegistration() else {
            return
        }
        
        Task {
            isLoading = true
            do {
                let result = try await repo.register(email: email, password: password)
                isLoading = false
              
                let userId = result.user.uid
                registerState = .registerSuccess
                
                try await Task.sleep(for: .seconds(1))
                loginState = .loginSuccess
                
                print("\(userId) is registered to firebase ")
                try await userRepo.saveUserToFirebase(accountNumber: accountNumber, email: email, name: name)
                
                clearRegisterFields()
                
            } catch {
                isLoading = false
                errorMessage = error.localizedDescription
                registerState = .registerFailed
            }
        }
    }
    
    private func validateRegistration() -> Bool {
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
    
    private func clearLoginFields() {
        email = ""
        password = ""
    }
    
    private func clearRegisterFields() {
        email = ""
        name = ""
        password = ""
        confirmPassword = ""
    }
    
    
    
}
