//
//  CalendarView.swift
//  barberShop
//
//  Created by Daniel Ramirez on 15/03/26.
//

import SwiftUI
import SwiftData


struct CalendarView: View {
    
    @Binding var selectedtab: Int
    
    @Environment(\.modelContext) var context
    @EnvironmentObject var session: SessionManager
    
    @Query var appointments: [Appointment]
    
    @StateObject var viewModel = CalendarViewModel()
    
    @State private var selectedSlot: String?
    @State private var showConfirmation = false
    @State private var showAlert = false
    @State private var showSameAlert = false
    
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
                                    available: available,
                                    past: past
                                )
                                .onTapGesture {
                                    
                                    guard available else { return }
                                    guard !past else { return }
                                    guard let user = session.currentUser else { return }
                                    
                                    let hasAppointmentToday = appointments.contains {
                                        $0.userEmail == user.email &&
                                        Calendar.current.isDate($0.date, inSameDayAs: viewModel.selectedDate) &&
                                        !$0.isCancelled
                                    }
                                    
                                    if hasAppointmentToday {
                                        showSameAlert = true
                                        return
                                    }
                                    
                                    if (user.phone ?? "").isEmpty {
                                        showAlert = true
                                        return
                                    }
                                    
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
        .alert("Phone number required", isPresented: $showAlert) {
            Button("Go to Profile") {
                selectedtab = 2
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("You must add a phone number in your profile before booking an appointment.")
        }
        .alert("You already have an appointment today", isPresented: $showSameAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

//#Preview {
//    CalendarView(selectedtab: 0)
//        .environmentObject(SessionManager())
//}
