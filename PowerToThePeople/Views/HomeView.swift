//
//  ContentView.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.19.
//

import SwiftUI
import SwiftData

// TO-DO
// FEATURES
// SwiftData data specs - COMPLETED
// Front and back recording, permissions - COMPLETED
// Emergency contacts - COMPLETED
// File storage + organization - COMPLETED
// Display recorded front/back video and metadata - IN PROGRESS
// Toast notifications for video start/stop - NOT STARTED

// FIXES
// Background handling - NOT STARTED
// Permissions handling - NOT STARTED

struct HomeView: View {
    @State private var isTapped = false
    @State private var isActivated = false
    
    var body: some View {
            VStack {
                Spacer()
                ZStack {
                    Circle()
                        .frame(width: 200, height: 200)
                        .foregroundStyle(Color.blue)
                        .onLongPressGesture(minimumDuration: 2.0, maximumDistance: 100) {
                            isActivated = true
                            
                        } onPressingChanged: { inProgress in
                            isTapped = inProgress
                        }
                    Text(isTapped ? "Keep holding..." : "Hold to activate")
                        .foregroundStyle(Color.white)
                }
                
                NavigationLink {
                    RightsDisplay(startRecordingOnAppear: false)
                } label: {
                    Text("View rights")
                }.padding()
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(isTapped ? Color.blue : nil)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden()
            .navigationDestination(isPresented: $isActivated) {
                RightsDisplay(startRecordingOnAppear: true)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink {
                        RecordingsView()
                    } label: {
                        Text("Past Recordings")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        ContactsView()
                    } label: {
                        Image(systemName: "person.circle")
                    }
                }
        }
    }
    
    private func requestPermissions() {
        VideoCaptureService.attemptAuthorization()
    }
    
    private func addItem() {
        // Stub from demo
    }

    private func deleteItems(offsets: IndexSet) {
        // Stub from demo
    }
}

#Preview {
    HomeView()
}
