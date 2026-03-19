//
//  DashboardCard.swift
//  barberShop
//
//  Created by Daniel Ramirez on 17/03/26.
//

import SwiftUI

struct DashboardCard: View {
    
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 10) {
            
            Image(systemName: icon)
                .font(.title)
            
            Text(value)
                .font(.title.bold())
            
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 100)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    DashboardCard(title: "Title", value: "Value", icon: "person")
}
