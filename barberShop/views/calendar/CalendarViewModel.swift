//
//  CalendarViewModel.swift
//  barberShop
//
//  Created by Daniel Ramirez on 15/03/26.
//

import SwiftUI
import SwiftData
import Combine

class CalendarViewModel: ObservableObject {
    
    @Published var selectedDate: Date = Date()
    
    let calendar: Calendar = .current
    
    var timeSlots: [String] {
        
        var slots: [String] = []
        
        for hour in 13...22 {
            slots.append("\(hour):00")
        }
        return slots
    }
    
    func isAvailable(
        slot: String,
        appointments: [Appointment]
    ) -> Bool {
        !appointments.contains {
            Calendar.current.isDate($0.date, inSameDayAs: selectedDate)
            && $0.timeSlot == slot
            && !$0.isCancelled
        }
    }
    
    func book(
        slot: String,
        user: User,
        appointments: [Appointment],
        context: ModelContext
    ) {
        
        let alradyBooked = userHasAppointmentToday(
            appointments: appointments,
            email: user.email
        )
        
        guard !alradyBooked else { return }
        
        let appointment = Appointment(
            date: selectedDate,
            timeSlot: slot,
            userEmail: user.email
        )
        
        context.insert(appointment)
    }
    
    func isPastTime(slot: String) -> Bool {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        guard let slotTime = formatter.date(from: slot) else { return false }
        
        let calendar = Calendar.current
        
        let now = Date()
        
        let components = calendar.dateComponents([.hour, .minute], from: slotTime)
        
        let slotDate = calendar.date(
            bySettingHour: components.hour!,
            minute: components.minute!,
            second: 0,
            of: selectedDate
        )!
        
        return slotDate < now
    }
    
    func userHasAppointmentToday(
        appointments: [Appointment],
        email: String
    ) -> Bool {
        
        appointments.contains {
            Calendar.current.isDate($0.date, inSameDayAs: selectedDate)
            && $0.userEmail == email
            && !$0.isCancelled
        }
    }
}
