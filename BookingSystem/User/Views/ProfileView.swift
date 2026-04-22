//
//  ProfileView.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-17.
//

import SwiftUI

struct ProfileView: View {
    @Environment(AuthViewModel.self) private var authViewModel
    @Environment(BookingViewModel.self) private var bookingViewModel
    
    @State private var userViewModel = UserViewModel()
    
    @State private var user: User?
    
    @State private var showSettings = false
    var body: some View {
        VStack {
            
            if let user = user {
                Text(user.name)
                
                Text(user.email)
            }
        }
        .environment(authViewModel)
        .task {
            if let userId = bookingViewModel.getUserId()
            {
                
                user = await userViewModel.getUserDetails(userId: userId)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                
                Button {
                    showSettings = true
                } label: {
                    Image(systemName: "gearshape.fill")
                }
            }
        }
        .navigationDestination(isPresented: $showSettings){
                   SettingsView()
            }
    }
}

#Preview {
    NavigationStack {
        ProfileView()
            .environment(BookingViewModel())
            
    }
  
       
      
}
