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
    
    private let sessionKey = "userSessionID"
    
    init() {
        if UserDefaults.standard.string(forKey: sessionKey) != nil {
            isLoggedIn = true
        }
    }
    
    func login(user: User) {
        currentUser = user
        isLoggedIn = true
        
        UserDefaults.standard.set(user.id.uuidString, forKey: sessionKey)
    }
    
    func logout() {
        currentUser = nil
        isLoggedIn = false
        
        UserDefaults.standard.removeObject(forKey: sessionKey)
    }
    
    func restoreSession(users: [User]) {
        
        guard isLoggedIn else { return }
        
        guard let savedIDString = UserDefaults.standard.string(forKey: sessionKey),
              let savedID = UUID(uuidString: savedIDString) else {
            logout()
            return
        }
        
        if let user = users.first(where: { $0.id == savedID }) {
            
            currentUser = user
            
        } else {
            
            logout()
        }
    }
}
