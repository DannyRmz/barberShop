//
//  MyAppointmentsView.swift
//  barberShop
//
//  Created by Daniel Ramirez on 16/03/26.
//

import SwiftUI
import SwiftData

struct MyAppointmentsView: View {
    
    @EnvironmentObject var session: SessionManager
    @Query var appointments: [Appointment]
    
    @StateObject var viewModel = MyAppointmentsViewModel()
    
    var body: some View {
        List {
            ForEach(
                viewModel.userAppointments(
                    appointments: appointments,
                    userEmail: session.currentUser?.email
                )
            ) { appointment in
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(appointment.timeSlot)
                            .font(.headline)
                        
                        Text(appointment.date, style: .date)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Button("Cancel") {
                        viewModel.cancelAppointment(appointment)
                    }
                    .foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("My Appointments")
    }
}

#Preview {
    MyAppointmentsView()
        .environmentObject(SessionManager())
}
