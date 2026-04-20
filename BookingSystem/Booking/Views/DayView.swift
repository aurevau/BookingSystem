//
//  DayView.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-17.
//

import SwiftUI

struct DayView: View {
    
    @State private var viewModel = DayViewModel()
    
    var currentDate: Date
   
    var body: some View {
        ScrollView {
            VStack {
//                Text(currentDate.fullMonthDayYearFormat())
                 
                Divider()
                    .padding(.vertical)
                Text("Välj en tid")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Längd: 30 minuter")
                
                ForEach(viewModel.dates, id: \.self) {date in
                    
                    HStack {
                        Button {
                            withAnimation {
                                viewModel.selectedDate = date
                            }
                        } label: {
                            Text((date?.timeFromDate())!)
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(viewModel.selectedDate == date ? .white : .blue)
                                .background(
                                    ZStack {
                                        if viewModel.selectedDate == date {
                                            RoundedRectangle(cornerRadius: 10)
                                                .foregroundColor(.gray)
                                        } else {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke()
                                        }
                                    }
                                )
                        }
                    
                        if viewModel.selectedDate == date {
                              
                            NavigationLink{
                                BookingView()
                            } label: {
                                Text("Nästa")
                                    .fontWeight(.bold)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.white)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(.blue)
                                    )
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack(spacing: 4) {
                    Text(currentDate.dayOfTheWeekFormat())
                                  .font(.headline)
                    
                    Text(currentDate.fullMonthDayYearFormat())
                                    .font(.subheadline)
                                    .foregroundColor(.black.opacity(0.8))
                }
                .padding(.top)
            }
        }
      
    }
}

#Preview {
    NavigationStack {
        DayView(currentDate: Date())
    }
   
}
