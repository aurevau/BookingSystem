//  DayView.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-17.
//

import SwiftUI

struct DayView: View {

//    @State private var viewModel = DayViewModel()
    
    @Environment(BookingViewModel.self) private var viewModel

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

                ForEach(viewModel.slots, id: \.self) { slot in

                    HStack {
                        Button {
                            withAnimation {
                                viewModel.selectedSlot = slot
                            }
                        } label: {
                            Text((slot.start.timeFromDate()))
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(viewModel.selectedSlot?.id == slot.id ? .white : .blue)
                                .background(
                                    ZStack {
                                        if viewModel.selectedSlot?.id == slot.id {
                                            RoundedRectangle(cornerRadius: 10)
                                                .foregroundColor(.gray)
                                        } else {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke()
                                        }
                                    }
                                )
                        }

                        if viewModel.selectedSlot?.id == slot.id {

                            NavigationLink{
                                BookingView(currentDate: slot.start)
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
        .onAppear {
            Task {
                await viewModel.fetchAvailableSlots(for: currentDate)
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
            .environment(BookingViewModel())
    }

}
