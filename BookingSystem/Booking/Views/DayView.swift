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
                    
                    Button {
                        
                    } label: {
                        Text((date?.timeFromDate())!)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke()
                                )
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
