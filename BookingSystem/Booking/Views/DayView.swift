//
//  DayView.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-17.
//

import SwiftUI

struct DayView: View {
    
    @State private var viewModel = DayViewModel()
   
    var body: some View {
        ScrollView {
            VStack {
                Text("17 April 2026")
                 
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
                                EmptyView()
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
        .navigationTitle("Fredag")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        DayView()
    }
   
}
