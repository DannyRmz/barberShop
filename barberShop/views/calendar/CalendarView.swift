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
    
    @State private var selectedSlot: String?
    @State private var showConfirmation = false
    
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
                    
                    let columns = [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                    ]
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 8) {
                            
                            ForEach(viewModel.timeSlots, id: \.self) { slot in
                                
                                let available = viewModel.isAvailable(
                                    slot: slot,
                                    appointments: appointments
                                )
                                
                                let past = viewModel.isPastTime(slot: slot)
                                
                                TimeSlotRow(
                                    time: slot,
                                    available: available && !past
                                )
                                .onTapGesture {
                                    
                                    guard available else { return }
                                    guard !past else { return }
                                    
                                    guard let user = session.currentUser else { return }
                                    
                                    guard user.phone != nil else {
                                        return
                                    }
                                    
                                    selectedSlot = slot
                                    showConfirmation = true
                                }
                            }
                        }
                        .padding()
                    }
                }
                .navigationTitle("Agenda")
            }
        }
        .alert("Confirm Appointment", isPresented: $showConfirmation) {
            
            Button("Confirm") {
                
                if let slot = selectedSlot, let user = session.currentUser {
                    
                    viewModel.book(
                        slot: slot,
                        user: user,
                        appointments: appointments,
                        context: context
                    )
                }
                
                selectedSlot = nil
            }
            
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Do you want to book this appointment?")
        }
    }
}

#Preview {
    CalendarView()
        .environmentObject(SessionManager())
}
