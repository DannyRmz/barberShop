//
//  SessionManager.swift
//  barberShop
//
//  Created by Daniel Ramirez on 12/03/26.
//

import SwiftUI
import Combine

class SessionManager: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    @Published var currentUser: User?
    
    func login(user: User) {
        currentUser = user
        isLoggedIn = true
    }
    
    func logout() {
        currentUser = nil
        isLoggedIn = false
    }
}
