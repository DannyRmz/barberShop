//
//  User.swift
//  barberShop
//
//  Created by Daniel Ramirez on 12/03/26.
//

import SwiftData

@Model
class User {
    
    var userName: String?
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
