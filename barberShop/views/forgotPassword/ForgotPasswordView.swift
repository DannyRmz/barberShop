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
        VStack(spacing: 20) {
            Text("Recover Password")
                .font(.largeTitle)
                .bold()
            
            TextField("Enter your email", text: $email)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
            
            Button("Send recobery email") {
                print("Recovery requested for \(email)")
            }
        }
        .padding()
    }
}

#Preview {
    ForgotPasswordView()
}
