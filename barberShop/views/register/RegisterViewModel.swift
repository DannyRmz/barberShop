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
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var createdUser: User?
    
    @Published var errorMessage: String?
    @Published var didRegisterSuccessfully = false
    
    func register(context: ModelContext, users: [User]) {
        
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
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
        
        let cleanEmail = email
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        
        let newUser = User(name: name, email: cleanEmail, password: password)
        context.insert(newUser)
        
        createdUser = newUser
        errorMessage = nil
        didRegisterSuccessfully = true
    }
}
