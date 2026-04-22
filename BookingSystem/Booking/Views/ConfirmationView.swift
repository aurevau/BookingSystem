//
//  ConfirmationView.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-19.
//

import SwiftUI

struct ConfirmationView: View {
    
    @Environment(BookingViewModel.self) private var viewModel
    
    @State private var isCancelled = false
    
    var currentDate: Date
    var body: some View {
        VStack {
          
            Image("busungarna")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()
            
            Text(isCancelled ? "Avbokad!" : " Bekräftad!")
                .font(.title3)
                .fontWeight(.bold)
                
            Text(isCancelled ? "Din tid är avbokad!" : "Du har en schamalagd inlämning på Busungarna")
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
        .onAppear {
            Task {
                if let userId = viewModel.getUserId() {
                    await viewModel.fetchMyBookings(userId: userId)
                }
            }
        }
        .padding()
        
        VStack(alignment: .leading, spacing: 20) {
            
            HStack {
                Circle()
                    .frame(width: 16, height: 16)
                    .foregroundColor(isCancelled ? .red : .green)
                
                Text(isCancelled ?  "Avbokad" : "Inlämning Busungarna, 30 min")
                    .fontWeight(.bold)
               
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
                Image(systemName: "calendar")
                
                Text("\(currentDate.dayOfTheWeekFormat()) \(currentDate.fullMonthDayYearFormat())")
            }
            
            HStack {
                Image(systemName: "creditcard")
                
                Text("Kostnadsfritt")
            }
            
            Spacer()
            
            NavigationLink {
                CalendarView()
            } label: {
                Text("Klar")
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.black))
                        
            }
            
            if let booking = viewModel.getMyBooking(for: currentDate) {
                Button {
                    Task{
                        if let userId = viewModel.getUserId() {
                            await viewModel.cancelBooking(slot: booking, userId: userId)
                            isCancelled = true
                        }
                    }
                } label: {
                    Text("Avboka")
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .foregroundColor(.red))
                }
            }
            
            
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
        
        .foregroundColor(Color(.systemGray))

    }
}

#Preview {
    NavigationStack {
        ConfirmationView(currentDate: Date())
            .environment(BookingViewModel())

    }
}
