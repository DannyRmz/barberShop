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
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(.roundedBorder)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)
                
                Button("Login") {
                    viewModel.login(users: users, session: session)
                }
                
                NavigationLink("Create account") {
                    RegisterView()
                }
                NavigationLink("Forgot password?") {
                    ForgotPasswordView()
                }
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
