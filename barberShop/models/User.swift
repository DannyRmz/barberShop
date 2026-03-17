//
//  User.swift
//  barberShop
//
//  Created by Daniel Ramirez on 12/03/26.
//

import SwiftUI
import SwiftData

@Model
class User {
    
    var id: UUID
    var name: String
    var email: String
    var password: String
    var phone: String?
    var isAdmin: Bool
    
    var profileImage: Data?
    
    init(id: UUID = UUID(), name: String, email: String, password: String, phone: String? = nil, isAdmin: Bool = false) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.phone = phone
        self.isAdmin = isAdmin
    }
}
