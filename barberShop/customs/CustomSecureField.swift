//
//  CustomSecureField.swift
//  barberShop
//
//  Created by Daniel Ramirez on 14/03/26.
//

import SwiftUI

struct CustomSecureField: View {
    
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack {
            SecureField(placeholder, text: $text)
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
