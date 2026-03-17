//
//  RootView.swift
//  barberShop
//
//  Created by Daniel Ramirez on 12/03/26.
//

import SwiftUI
import SwiftData

struct RootView: View {
    
    @EnvironmentObject var session: SessionManager
    @Query var users: [User]
    
    var body: some View {
        Group {
            if session.isLoggedIn {
                MainView()
            } else {
                LoginView()
            }
        }
        .onAppear {
            session.restoreSession(users: users)
        }
    }
}

#Preview {
    RootView()
        .environmentObject(SessionManager())
}
