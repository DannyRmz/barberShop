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
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var session: SessionManager
    
    @Query var users: [User]
    
    @StateObject var viewModel = RegisterViewModel()
    
    var body: some View {
        ZStack {
            CustomBackground()
            
            VStack(spacing: 20) {
                Text("Create Account")
                    .font(.largeTitle)
                    .bold()
                
                CustomTextField(placeholder: "Name", text: $viewModel.name)
                
                CustomTextField(placeholder: "Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                
                CustomSecureField(placeholder: "Password", text: $viewModel.password)
                
                CustomSecureField(placeholder: "Password", text: $viewModel.confirmPassword)
                
//                Button("Register") {
//                    viewModel.register(context: context, users: users)
//                }
                Button {
                    viewModel.register(context: context, users: users)
                } label: {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.name.isEmpty || viewModel.email.isEmpty || viewModel.password.isEmpty || viewModel.confirmPassword.isEmpty)
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                }
            }
            .padding()
        }
        .onChange(of: viewModel.didRegisterSuccessfully) { _, success in
            if success, let user = viewModel.createdUser {
                
                session.login(user: user)
                
                dismiss()
            }
        }
    }
}

#Preview {
    RegisterView()
        .environmentObject(SessionManager())
}
