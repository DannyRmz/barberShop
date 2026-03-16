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
            
            Tab("Agenda", systemImage: "calendar") {
                NavigationStack {
                    CalendarView()
                }
            }
            
            Tab("Appointments", systemImage: "list.bullet") {
                NavigationStack {
                    MyAppointmentsView()
                }
            }
            
            Tab("Profile", systemImage: "person") {
                NavigationStack {
                    ProfileView()
                }
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(SessionManager())
}
