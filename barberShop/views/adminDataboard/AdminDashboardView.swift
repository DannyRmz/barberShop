//
//  AdminDashboardView.swift
//  barberShop
//
//  Created by Daniel Ramirez on 17/03/26.
//

import SwiftUI
import SwiftData

struct AdminDashboardView: View {
    
    @Query var appointments: [Appointment]
    @Query var users: [User]
    
    @StateObject var viewModel = AdminDashboardViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]) {
                    
                    DashboardCard(
                        title: "Today",
                        value: "\(viewModel.appointmentsToday(appointments).count)",
                        icon: "calendar"
                    )
                    
                    DashboardCard(
                        title: "Users",
                        value: "\(viewModel.totalUsers(users))",
                        icon: "person.3"
                    )
                    
                    DashboardCard(
                        title: "Today",
                        value: "\(viewModel.bookedSlotsToday(appointments))",
                        icon: "clock"
                    )
                    
                    DashboardCard(
                        title: "Upcoming",
                        value: "\(viewModel.upcomingAppointments(appointments).count)",
                        icon: "list.bullet"
                    )
                }
                
                VStack(alignment: .leading) {
                    Text("Upcoming Appointments")
                        .font(.headline)
                    
                    ForEach(viewModel.upcomingAppointments(appointments)) { appointment in
                        
                        VStack(alignment: .leading) {
                            Text(appointment.timeSlot)
                            Text(appointment.date.formatted())
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Dashboard")
    }
}

#Preview {
    AdminDashboardView()
}
