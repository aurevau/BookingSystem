//
//  DayView.swift
//  BookingSystem
//
//  Created by Aurelie Vaudan APP25 on 2026-04-17.
//

import SwiftUI

struct DayView: View {
    @State private var dates = [
        Date(),
        Calendar.current.date(byAdding: .hour, value: 1, to: Date()),
        Calendar.current.date(byAdding: .hour, value: 2, to: Date()),
        Calendar.current.date(byAdding: .hour, value: 3, to: Date()),
        Calendar.current.date(byAdding: .hour, value: 4, to: Date())
    ]
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
                
                ForEach(dates, id: \.self) {date in
                    
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
