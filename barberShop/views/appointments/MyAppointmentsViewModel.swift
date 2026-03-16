//
//  MyAppointmentsViewModel.swift
//  barberShop
//
//  Created by Daniel Ramirez on 16/03/26.
//

import SwiftUI
import Combine

class MyAppointmentsViewModel: ObservableObject {
    
    func userAppointments(
        appointments: [Appointment],
        userEmail: String?
    ) -> [Appointment] {
        
        guard let email = userEmail else { return [] }
        
        return appointments.filter {
            $0.userEmail == email && !$0.isCancelled
        }
        .sorted { $0.date < $1.date }
    }
    
    func cancelAppointment( _ appointment: Appointment) {
        appointment.isCancelled = true
    }
}
