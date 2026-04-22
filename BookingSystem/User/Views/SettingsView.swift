//
//  SettingsView.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-21.
//

import SwiftUI

struct SettingsView: View {
    @Environment(AuthViewModel.self) private var viewModel

    var body: some View {
        VStack {
            
            Spacer()
            
            
            
            
            Divider()
            Button {
                viewModel.logOut()
            } label: {
                Text("Log out")
                    .foregroundColor(.red)
            }
            
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingsView()
        .environment(AuthViewModel())
}
