//
//  MainView.swift
//  barberShop
//
//  Created by Daniel Ramirez on 12/03/26.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    @EnvironmentObject var session: SessionManager
    @State private var selectedTab = 0
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            Tab("Agenda", systemImage: "calendar", value: 0) {
                NavigationStack {
                    CalendarView(selectedtab: $selectedTab)
                }
            }
            
            Tab("Appointments", systemImage: "list.bullet", value: 1) {
                NavigationStack {
                    if session.currentUser?.isAdmin == true {
                        AdminAppointmentsView()
                    } else {
                        MyAppointmentsView()
                    }
                }
            }
            
            Tab("Profile", systemImage: "person", value: 2) {
                NavigationStack {
                    ProfileView()
                }
            }
            
            if session.currentUser?.isAdmin == true {
                Tab("Admin", systemImage: "chart.bar", value: 3) {
                    NavigationStack {
                        AdminDashboardView()
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(SessionManager())
}
