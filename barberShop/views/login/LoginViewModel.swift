//
//  LoginViewModel.swift
//  barberShop
//
//  Created by Daniel Ramirez on 12/03/26.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var errorMessage: String?
    
    func login(users: [User], session: SessionManager) {
        
        let cleanEmail = email
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        
        guard !cleanEmail.isEmpty, !password.isEmpty else {
            errorMessage = "All fields are required"
            return
        }
        
        
        if let user = users.first(where: {
            $0.email == cleanEmail && $0.password == password
        }) {
            
            errorMessage = nil
            session.login(user: user)
            
        } else {
            errorMessage = "Invalid credentials"
        }
    }
}
