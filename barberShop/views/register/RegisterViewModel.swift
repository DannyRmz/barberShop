//
//  RegisterViewModel.swift
//  barberShop
//
//  Created by Daniel Ramirez on 12/03/26.
//

import SwiftUI
import SwiftData
import Combine

class RegisterViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var errorMessage: String?
    
    func register(context: ModelContext, users: [User]) {
        
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "All fields are required"
            return
        }
        
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return
        }
        
        guard email.contains("@") else {
            errorMessage = "Invalid email"
            return
        }
        
        if users.contains(where: { $0.email == email }) {
            errorMessage = "Email already in use"
            return
        }
        
        let newUser = User(email: email, password: password)
        context.insert(newUser)
        
        errorMessage = nil
    }
}
