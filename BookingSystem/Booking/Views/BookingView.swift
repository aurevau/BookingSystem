//
//  BookingView.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-17.
//

import SwiftUI

struct BookingView: View {
    @State private var viewModel = BookingViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("busungarna")
                    .resizable()
                    .scaledToFill()
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
                            Image(systemName: "lessthan")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.gray)
                            
                            
                        }
                        
                        Spacer()
                        
                        Text(viewModel.selectedDate.monthYearFormat())
                            .font(.title2)
                        
                        Spacer()
                        Button {
                            withAnimation {
                                viewModel.selectedMonth += 1
                            }
                        } label: {
                            Image(systemName: "greaterthan")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
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
                                NavigationLink(destination: {
                                    EmptyView()
                                }, label: {
                                    if value.day != -1 {
                                        Text("\(value.day)")
                                            .foregroundColor(value.day % 2 != 0 ? .blue : .black)
                                            .fontWeight(value.day % 2 != 0 ? .bold : .none)
                                            .background {
                                                ZStack(alignment: .bottom) {
                                                    Circle()
                                                        .frame(width: 48, height: 48)
                                                        .foregroundColor(value.day % 2 != 0 ? .blue.opacity(0.1) : .clear)
                                                    if value.date.string() == Date().string() {
                                                        Circle()
                                                            .frame(width: 8, height: 8)
                                                            .foregroundColor(value.day % 2 != 0 ? .blue : .gray)
                                                    }
                                                }
                                            }
                                            
                                    } else {
                                        Text("")
                                    }
                                })
                                .disabled(value.day % 2 == 0)
                            }
                            .frame(width: 32, height: 32)
                         
                        }
                    }
                }
                .padding()
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        
    }
}

#Preview {
    BookingView()
}
