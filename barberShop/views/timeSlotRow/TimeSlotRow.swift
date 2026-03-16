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
    let past: Bool
    
    var body: some View {
        
        HStack {
            Text(time)
                .font(.headline)
            
            Spacer()
            
            if past {
                Label("Past", systemImage: "clock.fill")
                    .foregroundStyle(.gray)
            } else if available {
                Label("Available", systemImage: "checkmark.circle.fill")
                    .foregroundStyle(.green)
            } else {
                Label("Booked", systemImage: "xmark.circle.fill")
                    .foregroundStyle(.red)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(backgroundColor)
        )
    }
    
    var backgroundColor: Color {
        if past { return .gray.opacity(0.1) }
        if available { return .green.opacity(0.1) }
        return .red.opacity(0.1)
    }
}
