//
//  AdminAppointmentsView.swift
//  barberShop
//
//  Created by Daniel Ramirez on 16/03/26.
//

import SwiftUI
import SwiftData

struct AdminAppointmentsView: View {
    
    @Query var appointments: [Appointment]
    @Query var users: [User]
    
    var body: some View {
        List {
            ForEach(appointments.filter { !$0.isCancelled }) { appointment in
                if let user = users.first(where: { $0.email == appointment.userEmail }) {
                    
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        
                        Text(user.phone ?? "")
                        
                        Text(appointment.timeSlot)
                            .foregroundStyle(.secondary)
                        
                        Text(appointment.date, style: .date)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            appointment.isCancelled = true
                        } label: {
                            Label("Cancel", systemImage: "trash")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AdminAppointmentsView()
}
