//
//  MainView.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-17.
//

import SwiftUI

struct MainView: View {
    @Environment(AuthViewModel.self) private var viewModel
    @State private var userViewModel =  UserViewModel()
    var body: some View {
        Text("Hello")
        
        switch userViewModel.userRole {
        case .guest: Text("Guest")
        case .user: Text("User")
        case .admin: Text("Admin")
        }
        
        Button("Log Out") {
            viewModel.logOut()
        }
    }
}

#Preview {
    MainView()
}
