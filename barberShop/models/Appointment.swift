//
//  Appointment.swift
//  barberShop
//
//  Created by Daniel Ramirez on 15/03/26.
//

import SwiftUI
import SwiftData

@Model
class Appointment {
    
    var date: Date
    var timeSlot: String
    var userEmail: String
    var isCancelled: Bool
    
    init(date: Date, timeSlot: String, userEmail: String) {
        self.date = date
        self.timeSlot = timeSlot
        self.userEmail = userEmail
        self.isCancelled = false
    }
}
