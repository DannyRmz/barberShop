//
//  RegisterView.swift
//  barberShop
//
//  Created by Daniel Ramirez on 12/03/26.
//

import SwiftUI
import SwiftData

struct RegisterView: View {
    
    @Environment(\.modelContext) var context
    @Query var users: [User]
    
    @StateObject var viewModel = RegisterViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle)
            
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Confirm Password", text: $viewModel.confirmPassword)
                .textFieldStyle(.roundedBorder)
            
            Button("Register") {
                viewModel.register(context: context, users: users)
            }
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
            }
        }
        .padding()
    }
}

#Preview {
    RegisterView()
}
