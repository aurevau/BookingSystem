//
//  LoginView.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-16.
//

import SwiftUI

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    
    var body: some View {
        
        NavigationStack {
            VStack{
                List {
                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    Button {
                        viewModel.login()
                    } label: {
                        Text("Login")
                    }
                    
                    NavigationLink("New around here? Register") {
                        OnboardingView()
                    }
                }
            }
            
            .navigationTitle("Login")
            
        }
    }
}

#Preview {
    LoginView()
}
