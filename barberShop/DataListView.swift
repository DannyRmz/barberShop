//
//  DataListView.swift
//  barberShop
//
//  Created by Daniel Ramirez on 13/03/26.
//

import SwiftUI
import SwiftData

struct DataListView: View {
    
    @Query var users: [User]
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                Text(user.email)
                    .font(.headline)
                
                Text(user.password)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
        }
        .navigationTitle("Users")
    }
}

#Preview {
    DataListView()
}
