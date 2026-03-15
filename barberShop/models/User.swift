//
//  User.swift
//  barberShop
//
//  Created by Daniel Ramirez on 12/03/26.
//

import SwiftData

@Model
class User {
    
    var name: String
    var email: String
    var password: String
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
}
