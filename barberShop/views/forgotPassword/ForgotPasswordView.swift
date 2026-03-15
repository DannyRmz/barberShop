//
//  ForgotPasswordView.swift
//  barberShop
//
//  Created by Daniel Ramirez on 12/03/26.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var email: String = ""
    
    var body: some View {
        ZStack {
            Color.cyan.opacity(0.1)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Recover Password")
                    .font(.largeTitle)
                    .bold()
                
                CustomTextField(placeholder: "Enter your email", text: $email)
                    .keyboardType(.emailAddress)
                
                Button("Send recobery email") {
                    print("Recovery requested for \(email)")
                }
                .disabled(email.isEmpty)
            }
            .padding()
        }
    }
}

#Preview {
    ForgotPasswordView()
}
