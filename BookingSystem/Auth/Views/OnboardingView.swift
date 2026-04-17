//
//  OnboardingView.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-16.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(AuthViewModel.self) private var viewModel
    
    var body: some View {
        @Bindable var vm = viewModel
        NavigationStack {
            VStack(spacing: 20) {
            
                    TextField("Username", text: $vm.name)
                        .autocorrectionDisabled()
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    TextField("Email", text: $vm.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    
                    SecureField("Password", text: $vm.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    SecureField("Confirm Password", text: $vm.confirmPassword)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundStyle(.red)
                        
                    }
                
                
                if viewModel.registerState == .registerSuccess {
                    Text("Registration was successfull")
                        .foregroundColor(.green)
                }
                    
                    Button {
                        viewModel.register()
                           
                    } label: {
                        
                        if viewModel.isLoading {
                                ProgressView()
                        } else {
                            Text("Create Account")
                        }
                       
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
