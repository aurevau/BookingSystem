//
//  BookingView.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-19.
//

import SwiftUI

struct BookingView: View {
    
    @State private var viewModel = BookingViewModel()
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 20) {
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
            }
            .padding()
           
            
            Divider()
       
            VStack(alignment: .leading, spacing: 16) {
                Text("Skriv i dina uppgifter")
                    .font(.subheadline)
                    .fontWeight(.bold)
                   
                
                Text("Namn*")
                
                TextField("", text: $viewModel.name)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                    )
              
                Text("Email*")
                TextField("", text:  $viewModel.email)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                    )
                
                Text("Vänligen dela med dig av allt som kan hjälpa förbereda oss inför din inlämning")
                TextField("", text: $viewModel.notes, axis: .vertical )
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                    )
                
                Spacer()
                
                NavigationLink {
                    EmptyView()
                } label: {
                    Text("Boka inlämning")
                }
                .padding()
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                       
                )
               
            
            }
            .font(.caption)
            .fontWeight(.bold)
            .padding()
            .foregroundColor(.black)
            
        }
       
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .navigationTitle("Busungarna inlämning")
        .foregroundColor(Color(.systemGray))
    }
}

#Preview {
    NavigationStack {
        BookingView()
    }
    
}
