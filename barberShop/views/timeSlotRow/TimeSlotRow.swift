//
//  TimeSlotRow.swift
//  barberShop
//
//  Created by Daniel Ramirez on 15/03/26.
//

import SwiftUI

struct TimeSlotRow: View {
    
    let time: String
    let available: Bool
    
    var body: some View {
        
        HStack {
            Text(time)
                .font(.headline)
            
            Spacer()
            
            Text(available ? "Available" : "Booked")
                .foregroundStyle(available ? .green : .red)
                .strikethrough(!available)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            available ? Color.green.opacity(0.1) : Color.red.opacity(0.1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
