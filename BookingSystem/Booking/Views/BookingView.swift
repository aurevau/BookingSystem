//
//  BookingView.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-19.
//

import SwiftUI

struct BookingView: View {
    
    @Environment(BookingViewModel.self) private var viewModel
    
    @State private var navigateToConfirmation = false


    
    

    var currentDate: Date
    var body: some View {
        @Bindable var vm = viewModel
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    Image(systemName: "calendar")
                    
                    Text("\(currentDate.dayOfTheWeekFormat()) \(currentDate.fullMonthDayYearFormat())")
                }
                
                HStack {
                    Image(systemName: "clock")
                    
                    Text(currentDate.bookingTimeIntervalFormat())
                }
                
                HStack {
                    Image(systemName: "mappin")
                    
                    Text("Industrivägen 24, 135 40 Tyresö")
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
                
                TextField("", text: $vm.name)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                    )
              
                Text("Email*")
                TextField("", text:  $vm.email)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                    )
                
                Text("Vänligen dela med dig av allt som kan hjälpa förbereda oss inför din inlämning")
                TextField("", text: $vm.notes, axis: .vertical )
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                    )
                
                Spacer()
                
                Button {
                    Task {
                        await viewModel.confirmBooking(slot: viewModel.selectedSlot, userId: viewModel.getUserId())
                        navigateToConfirmation = true
                    }
                } label: {
                    Text("Boka inlämning")
                }
                .navigationDestination(isPresented: $navigateToConfirmation) {
                    ConfirmationView(currentDate: currentDate)
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
        BookingView(currentDate: Date())
            .environment(BookingViewModel())
    }
    
}
