//
//  ProfileView.swift
//  barberShop
//
//  Created by Daniel Ramirez on 15/03/26.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var session: SessionManager
    
    @State private var phone = ""
    
    var body: some View {
        
        if let user = session.currentUser {
            ZStack {
                Color.cyan.opacity(0.1)
                    .ignoresSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 32) {
                    HStack {
                        
                        Text(user.name)
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.gray)
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Email")
                            .foregroundStyle(.secondary)
                        Text(user.email)
                            .font(.headline)
                    }
                    
                    CustomTextField(placeholder: "Phone number", text: $phone)
                        .keyboardType(.phonePad)
                    
                    Button("Save") {
                        user.phone = phone
                    }
                    
                    Spacer()
                    
                }
                .padding()
                .navigationBarTitle("Profile")
            }
            
        } else {
            Text("No user logged in")
        }
    }
}

#Preview {
    NavigationStack {
        let session = SessionManager()
            session.currentUser = User(
                name: "Daniel Ramírez",
                email: "daniel@mail.com",
                password: "1234"
            )
        
        return ProfileView()
                .environmentObject(session)
    }
}
