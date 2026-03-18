//
//  AdminAppointmentsViewModel.swift
//  barberShop
//
//  Created by Daniel Ramirez on 17/03/26.
//

import SwiftUI
import Combine

class AdminAppointmentsViewModel: ObservableObject {
    
    func activeAppointments(from appointments: [Appointment]) -> [Appointment] {
        appointments.filter { !$0.isCancelled }
    }
    
    func user(for appointment: Appointment, users: [User]) -> User? {
        users.first { $0.email == appointment.userEmail }
    }
    
    func cancel(_ appointment: Appointment) {
        appointment.isCancelled = true
    }

}
