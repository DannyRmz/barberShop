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
    
    @StateObject var viewModel = AdminAppointmentsViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.activeAppointments(from: appointments)) { appointment in
                if let user = viewModel.user(for: appointment, users: users) {
                    
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
                            viewModel.cancel(appointment)
                        } label: {
                            Label("Cancel", systemImage: "trash")
                        }
                    }
                }
            }
        }
        .navigationTitle("Admin Panel")
    }
}

#Preview {
    AdminAppointmentsView()
        .environmentObject(SessionManager())
}
