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
            calendar.isDate($0.date, inSameDayAs: selectedDate) && $0.timeSlot == slot
        }
    }
    
    func book(
        slot: String,
        userEmail: String,
        appointments: [Appointment],
        context: ModelContext
    ) {
        let exists = appointments.contains {
            Calendar.current.isDate($0.date, inSameDayAs: selectedDate)
            && $0.timeSlot == slot
            && !$0.isCancelled
        }
        
        guard !exists else { return }
        
        if !exists {
            let appointment = Appointment(
                date: selectedDate,
                timeSlot: slot,
                userEmail: userEmail
            )
            
            context.insert(appointment)
        }
    }
}
