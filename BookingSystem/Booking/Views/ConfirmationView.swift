//
//  ConfirmationView.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-19.
//

import SwiftUI

struct ConfirmationView: View {
    var body: some View {
        VStack {
          
            Image("busungarna")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()
            
            Text("Bekräftad!")
                .font(.title3)
                .fontWeight(.bold)
                
            Text("Du har en schamalagd inlämning på Busungarna")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.black.opacity(0.9))
                .padding(.horizontal, 16)
                .padding(.vertical, 6)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(.systemGray6))
                )
                
            
            Divider()
                .padding(6)

            
            
        }
        .padding()
        
        VStack(alignment: .leading, spacing: 20) {
            
            HStack {
                Circle()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.green)
                
                Text("Inlämning Busungarna, 30 min")
                    .fontWeight(.bold)
               
            }
            HStack {
                Image(systemName: "clock")
                
                Text("30 minuter")
            }
            
            HStack {
                Image(systemName: "mappin")
                
                Text("Industrivägen 24, 135 40 Tyresö")
            }
            
            HStack {
                Image(systemName: "calendar")
                
                Text("Saturday 19 April 2026")
            }
            
            HStack {
                Image(systemName: "creditcard")
                
                Text("Kostnadsfritt")
            }
            
            Spacer()
            
            NavigationLink {
                MainView()
            } label: {
                Text("Klar")
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.black))
                        
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
        
        .foregroundColor(Color(.systemGray))

    }
}

#Preview {
    NavigationStack {
        ConfirmationView()

    }
}
