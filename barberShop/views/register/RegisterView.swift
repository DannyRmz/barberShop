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
        ZStack {
            Color.cyan.opacity(0.1)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Create Account")
                    .font(.largeTitle)
                    .bold()
                
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
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
                .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty || viewModel.confirmPassword.isEmpty)
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                }
            }
            .padding()
        }
    }
}

#Preview {
    RegisterView()
}
