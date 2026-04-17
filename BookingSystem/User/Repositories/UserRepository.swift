//
//  UserRepository.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-17.
//

import Foundation
import FirebaseFirestore

class UserRepository {
    
    private var db = Firestore.firestore()
    
    func saveUserToFirebase(accountNumber: Int, email: String, name: String) async throws {
        
        let newUser = User(accountNumber: accountNumber, name: name, email: email, joined: Date().timeIntervalSince1970)
        
        try db.collection("users")
            .document(newUser.id)
            .setData(from: newUser)
        
        print("User saved")
    }
}
