//
//  AdminDashboardViewModel.swift
//  barberShop
//
//  Created by Daniel Ramirez on 17/03/26.
//

import SwiftUI
import Combine

class AdminDashboardViewModel: ObservableObject {
    
    func appointmentsToday(_ appointments: [Appointment]) -> [Appointment] {
        appointments.filter {
            Calendar.current.isDate($0.date, inSameDayAs: Date()) && !$0.isCancelled
        }
    }
    
    func totalUsers(_ users: [User]) -> Int {
        users.count
    }
    
    func bookedSlotsToday(_ appointments: [Appointment]) -> Int {
        appointmentsToday(appointments).count
    }
    
    func upcomingAppointments(_ appointments: [Appointment]) -> [Appointment] {
        appointments
            .filter { !$0.isCancelled }
            .sorted { $0.date < $1.date }
    }
}
