//
//  OnboardingView.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-16.
//

import SwiftUI

struct OnboardingView: View {
    @State private var viewModel = RegisterViewModel()


    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
            
                    TextField("Username", text: $viewModel.name)
                        .autocorrectionDisabled()
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    SecureField("Confirm Password", text: $viewModel.confirmPassword)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundStyle(.red)
                        
                    }
                    
                    Button {
                        viewModel.register()
                           
                    } label: {
                        Text("Create Account")
                    }
                    
                
                
                NavigationLink("Already a user?") {
                    LoginView()
                        .navigationBarBackButtonHidden(true)
                }
            }
            .padding()
            .navigationTitle("Welcome to registration")
        }
        
    }
}

#Preview {
    OnboardingView()
}
