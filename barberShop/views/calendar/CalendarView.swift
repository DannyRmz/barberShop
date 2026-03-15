//
//  CalendarView.swift
//  barberShop
//
//  Created by Daniel Ramirez on 15/03/26.
//

import SwiftUI


struct CalendarView: View {
    
    @EnvironmentObject var session: SessionManager
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Welcome")
                    .font(.largeTitle)
                    .bold()
                
                if let user = session.currentUser {
                    Text(user.email)
                }
                
                Button("Logout") {
                    session.logout()
                }
                
                NavigationLink("Users") {
                    DataListView()
                }
            }
        }
    }
}

#Preview {
    CalendarView()
        .environmentObject(SessionManager())
}
