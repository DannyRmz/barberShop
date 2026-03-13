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
        
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "All fields are required"
            return
        }
        
        
        if let user = users.first(where: {
            $0.email == email && $0.password == password
        }) {
            session.login(user: user)
        }
    }
}
