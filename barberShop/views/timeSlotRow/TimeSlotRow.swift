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
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            available ? Color.green.opacity(0.2) : Color.red.opacity(0.2)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
