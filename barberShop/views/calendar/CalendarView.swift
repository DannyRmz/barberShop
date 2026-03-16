//
//  CalendarView.swift
//  barberShop
//
//  Created by Daniel Ramirez on 15/03/26.
//

import SwiftUI
import SwiftData


struct CalendarView: View {
    
    @Environment(\.modelContext) var context
    @EnvironmentObject var session: SessionManager
    
    @Query var appointments: [Appointment]
    
    @StateObject var viewModel = CalendarViewModel()
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                CustomBackground()
                
                VStack {
                   DatePicker(
                    "Select date",
                    selection: $viewModel.selectedDate,
                    displayedComponents: .date
                   )
                   .datePickerStyle(.compact)
                   .padding()
                    
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            
                            ForEach(viewModel.timeSlots, id: \.self) { slot in
                                
                                let available = viewModel.isAvailable(
                                    slot: slot,
                                    appointments: appointments
                                )
                                
                                TimeSlotRow(
                                    time: slot,
                                    available: available
                                )
                                .onTapGesture {
                                    
                                    guard let email = session.currentUser?.email else { return }
                                    
                                    viewModel.book(
                                        slot: slot,
                                        userEmail: email,
                                        appointments: appointments,
                                        context: context
                                    )
                                }
                            }
                        }
                        .padding()
                    }
                }
                .navigationTitle("Agenda")
            }
        }
    }
}

#Preview {
    CalendarView()
        .environmentObject(SessionManager())
}
