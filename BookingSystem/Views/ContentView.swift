//
//  ContentView.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-16.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(LoginViewModel.self) private var viewModel
    var body: some View {
        if !viewModel.isSignedIn {
            LoginView()
        } else {
            VStack {
                Text("Hej du lyckades logga in")
                
                Button("Logga ut") {
                    viewModel.logOut()
                }
            }
            .padding()
        }
       
    }
}

#Preview {
    ContentView()
}
