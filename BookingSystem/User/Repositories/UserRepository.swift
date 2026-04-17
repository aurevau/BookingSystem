//
//  UserRepository.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-17.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class UserRepository {
    
    private var db = Firestore.firestore()
    
    func saveUserToFirebase(accountNumber: Int, email: String, name: String) async throws {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let newUser = User(id: uid, accountNumber: accountNumber, userRole: UserRole.user, name: name, email: email, joined: Date().timeIntervalSince1970)
        
        try db.collection("users")
            .document(newUser.id)
            .setData(from: newUser)
        
        print("User saved")
    }
    
    func getUserRole() async throws -> UserRole {
        guard let uid = Auth.auth().currentUser?.uid else {
                return .guest
            }
        
        let document = try await db.collection("users")
            .document(uid)
            .getDocument(as: User.self)
        
        return document.userRole
        
    }
}
