//
//  ContentView.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.19.
//

import SwiftUI
import SwiftData

// TO-DO
// SwiftData data specs - COMPLETED
// Front and back recording, permissions - COMPLETED
// File storage + organization - IN PROGRESS
// Display video files - NOT STARTED

struct HomeView: View {
    @State private var isTapped = false
    @State private var isActivated = false
    
    var body: some View {
        NavigationStack {
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
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(isTapped ? Color.blue : nil)
            .ignoresSafeArea()
            .navigationDestination(isPresented: $isActivated) {
                RightsDisplay()
            }
            .toolbar {
                Button(action: navigateToContacts) {
                    Image(systemName: "gear")
                }
            }
        }
    }
    
    private func navigateToContacts() {
        // TO-DO: navigate to emergency contacts page
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
