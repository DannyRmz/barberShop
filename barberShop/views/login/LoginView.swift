//
//  LoginView.swift
//  barberShop
//
//  Created by Daniel Ramirez on 12/03/26.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    
    @EnvironmentObject var session: SessionManager
    @StateObject var viewModel = LoginViewModel()
    
    @Environment(\.modelContext) var context
    
    @Query var users: [User]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.cyan.opacity(0.1)
                    .ignoresSafeArea(.all)
                
                VStack(spacing: 20) {
                    Spacer()
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                    
                    CustomTextField(placeholder: "Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                    
                    CustomTextField(placeholder: "Password", text: $viewModel.password)
                    
                    NavigationLink("Forgot password?") {
                        ForgotPasswordView()
                    }
                    
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundStyle(.red)
                    }
                    
                    Button("Login") {
                        viewModel.login(users: users, session: session)
                    }
                    .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty)
                    
                    Spacer()
                    
                    NavigationLink("Create account") {
                        RegisterView()
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    LoginView()
}
