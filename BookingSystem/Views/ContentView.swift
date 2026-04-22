//
//  ContentView.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-16.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = AuthViewModel()
   

    var body: some View {
        VStack {
            switch viewModel.loginState {
            case .loginSuccess: CalendarView()
            case .notLoggedIn : LoginView()
            case .idle : ProgressView()
            case .error(message: _):
                Text("")
            }
        }
        .environment(viewModel)
        
        
            
        }
       
    }


#Preview {
    ContentView()
}
