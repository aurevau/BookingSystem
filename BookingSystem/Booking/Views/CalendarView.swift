//
//  BookingView.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-17.
//

import SwiftUI

struct CalendarView: View {
    @State private var viewModel = BookingViewModel()
    @Environment(AuthViewModel.self) private var authViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .trailing) {
                NavigationLink {
                    ProfileView()
                        .environment(authViewModel)
                } label: {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .cornerRadius(64)
                        .foregroundColor(.pink.opacity(0.4))
                }
            }
            .frame(maxWidth: .infinity, alignment: .topTrailing)
            .padding(.trailing)
           
            
            VStack {
                Image("busungarna")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 128, height: 128)
                    .cornerRadius(64)
                
                Text("Busungarna")
                    .font(.title)
                    .fontWeight(.bold)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                
                VStack(spacing: 20) {
                    Text("Välj en dag")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            withAnimation {
                                viewModel.selectedMonth -= 1
                            }
                        } label: {
                            Image(systemName: "lessthan.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.gray)
                            
                            
                        }
                        
                        Spacer()
                        
                        Text(viewModel.selectedMonthDate.monthYearFormat())
                            .font(.title2)
                        
                        Spacer()
                        Button {
                            withAnimation {
                                viewModel.selectedMonth += 1
                            }
                        } label: {
                            Image(systemName: "greaterthan.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.gray)
                            
                        }
                        
                        Spacer()
                        
                    }
                    
                    HStack {
                        ForEach(viewModel.days, id: \.self) {day in
                            Text(day)
                                .font(.system(size: 12, weight: .medium))
                                .frame(maxWidth: .infinity)
                            
                        }
                    }
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 20) {
                        ForEach(viewModel.fetchDates()) {value in
                           
                            ZStack {
                                if let booking = viewModel.getMyBooking(for: value.date) {
                                    NavigationLink {
                                        ConfirmationView(currentDate: booking.start)
                                    } label: {
                                        dayLabel(for: value, isBooked: true)
                                    }
                                } else {
                                    NavigationLink {
                                        DayView(currentDate: value.date)
                                            .environment(viewModel)
                                    } label: {
                                        dayLabel(for: value, isBooked: false)
                                    }
                                    .disabled(!viewModel.hasAvailableSlots(for: value.date))
                                }
                            }
                            .frame(width: 32, height: 32)
                            
                         
                        }
                    }
                }
                .padding()
                .onAppear {
                    Task {
                        await viewModel.fetchAvailableDates(for: viewModel.selectedMonthDate)
                        if let userId = viewModel.getUserId() {
                                    await viewModel.fetchMyBookings(userId: userId)
                                }
                        
                        
                    }
                }
                .onChange(of: viewModel.selectedMonth) {
                    Task {
                        await viewModel.fetchAvailableDates(for: viewModel.selectedMonthDate)
                        if let userId = viewModel.getUserId() {
                                    await viewModel.fetchMyBookings(userId: userId)
                                }
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .environment(viewModel)
        
    }
    
    @ViewBuilder
    func dayLabel(for value: CalendarDate, isBooked: Bool) -> some View {
        if value.day != -1 {
            Text("\(value.day)")
                .foregroundColor(isBooked ? .green : (viewModel.hasAvailableSlots(for: value.date) ? .blue : .black))
                .fontWeight(isBooked || viewModel.hasAvailableSlots(for: value.date) ? .bold : .none)
                .background {
                    ZStack(alignment: .bottom) {
                        Circle()
                            .frame(width: 48, height: 48)
                            .foregroundColor(isBooked ? .green.opacity(0.1) : (viewModel.hasAvailableSlots(for: value.date) ? .blue.opacity(0.1) : .clear))
                        if value.date.monthDayYearFormat() == Date().monthDayYearFormat() {
                            Circle()
                                .frame(width: 8, height: 8)
                                .foregroundColor(.gray)
                        }
                        if isBooked {
                            Circle()
                                .frame(width: 8, height: 8)
                                .foregroundColor(.green)
                                .offset(y: 4)
                        }
                    }
                }
        } else {
            Text("")
        }
    }
}

#Preview {
    CalendarView()
}
