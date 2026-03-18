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
                CustomBackground()
                
                VStack(spacing: 20) {
                    Spacer()
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                    
                    CustomTextField(placeholder: "Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                    
                    CustomSecureField(placeholder: "Password", text: $viewModel.password)
                    
                    NavigationLink("Forgot password?") {
                        ForgotPasswordView()
                    }
                    
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundStyle(.red)
                            .font(.caption)
                    }
                    
                    Button("Login") {
                        viewModel.login(users: users, session: session)
                    }
                    .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty)
                    
                    Spacer()
                    
                    NavigationLink("Create account") {
                        RegisterView()
                    }
                    
//                    Button("Creat admin") {
//                        let admin = User(
//                            name: "Admin",
//                            email: "admin@mail.com",
//                            password: "123456",
//                            phone: "5512345678",
//                            isAdmin: true
//                        )
//                        context.insert(admin)
//                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    LoginView()
}
