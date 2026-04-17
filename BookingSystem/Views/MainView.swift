//
//  MainView.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-17.
//

import SwiftUI

struct MainView: View {
    @Environment(AuthViewModel.self) private var viewModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Button("Log Out") {
            viewModel.logOut()
        }
    }
}

#Preview {
    MainView()
}
