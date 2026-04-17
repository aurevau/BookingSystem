//
//  LoginView.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-16.
//

import SwiftUI

struct LoginView: View {
    @Environment(AuthViewModel.self) private var viewModel
    

    var body: some View {
        @Bindable var vm = viewModel
            NavigationStack {
                VStack(spacing: 20){
                    
                        TextField("Email", text: $vm.email)
                            .textFieldStyle(DefaultTextFieldStyle())
                            .autocapitalization(.none)
                        SecureField("Password", text: $vm.password)
                            .textFieldStyle(DefaultTextFieldStyle())
                        
                        if !viewModel.errorMessage.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundColor(.red)
                        }
                    
                    
                        
                        Button {
                            viewModel.login()
                                
        
                        } label: {
                            if viewModel.isLoading {
                                    ProgressView()
                            } else {
                                Text("Login")
                            }
                        
                        }
                        
                        
                    
                    
                    NavigationLink("New around here? Register") {
                        OnboardingView()
                            .navigationBarBackButtonHidden(true)
                            .environment(viewModel)
                    }
                }
                
                .padding()
                
                .navigationTitle("Login")
                
            }
    
    }
}

#Preview {
    LoginView()
}
