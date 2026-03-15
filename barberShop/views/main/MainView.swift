//
//  MainView.swift
//  barberShop
//
//  Created by Daniel Ramirez on 12/03/26.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    var body: some View {
        
        TabView {
            Tab("Appointment", systemImage: "calendar") {
                NavigationStack {
                    CalendarView()
                }
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(SessionManager())
}
