//
//  barberShopApp.swift
//  barberShop
//
//  Created by Daniel Ramirez on 11/03/26.
//

import SwiftUI
import SwiftData

@main
struct barberShopApp: App {
    
    @StateObject var session = SessionManager()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(session)
        }
        .modelContainer(for: [ User.self, Appointment.self])
    }
}
