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
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome")
            
            if let user = session.currentUser {
                Text(user.email)
            }
            
            Button("Logout") {
                session.logout()
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(SessionManager())
}
