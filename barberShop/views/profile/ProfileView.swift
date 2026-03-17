//
//  ProfileView.swift
//  barberShop
//
//  Created by Daniel Ramirez on 15/03/26.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    
    @EnvironmentObject var session: SessionManager
    
    @State private var phone = ""
    @State private var isEditing = false
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var profileImage: Image?
    
    var body: some View {
        
        if let user = session.currentUser {
            ZStack {
                Color.cyan.opacity(0.1)
                    .ignoresSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 32) {
                    HStack {
                        
                        Text(user.name)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        PhotosPicker(selection: $selectedItem, matching: .images) {
                            ZStack {
                                if let data = user.profileImage,
                                   let uiImage = UIImage(data: data) {
                                    
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 120, height: 120)
                                        .clipped()
                                        .clipShape(Circle())
                                    
                                } else {
                                    Image(systemName: "person.crop.circle")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(.gray)
                                }
                                
                                VStack {
                                    Spacer()
                                    
                                    HStack {
                                        Spacer()
                                        
                                        Image(systemName: "camera.fill")
                                            .padding(6)
                                            .background(.black.opacity(0.5))
                                            .clipShape(Circle())
                                            .foregroundStyle(.white)
                                            
                                    }
                                }
                                .padding(6)
                            }
                            .frame(width: 120, height: 120)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .foregroundStyle(.secondary)
                        
                        Text(user.email)
                            .font(.headline)
                    }
                    
                    Text("Phone")
                        .foregroundStyle(.secondary)
                    
                    HStack {
                        if isEditing {
                            CustomTextField(placeholder: "Phone number", text: $phone)
                                .keyboardType(.phonePad)
                            
                        } else {
                            Text(user.phone ?? "No phone number")
                                .foregroundStyle(user.phone == nil ? .secondary : .primary)
                        }
                        
                        Spacer()
                        
                        Button {
                            if isEditing {
                                user.phone = phone
                            }
                            
                            isEditing.toggle()
                        } label: {
                            HStack {
                                Image(systemName: isEditing ? "checkmark" : "pencil")
                                Text(isEditing ? "Save" : "Edit")
                            }
                            .frame(width: 90)
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(isEditing && phone.isEmpty)
                    }
                    .frame(height: 36)
                    
                    Spacer()
                    
                    Button(role: .destructive) {
                        session.logout()
                    } label: {
                        Text("Log Out")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top)
                }
                .padding()
                .navigationBarTitle("Profile")
                .onChange(of: selectedItem) { _, newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            
                            if let uiImage = UIImage(data: data) {
                                user.profileImage = uiImage.jpegData(compressionQuality: 0.7)
                            }
                        }
                    }
                }
            }
            .onAppear {
                phone = user.phone ?? ""
            }
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
