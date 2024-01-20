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
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                ZStack {
                    Circle()
                        .frame(width: 200, height: 200)
                        .foregroundStyle(Color.blue)
                        .onLongPressGesture(minimumDuration: 2.0, maximumDistance: 100) {
                            print("Activated")
                        } onPressingChanged: { inProgress in
                            isTapped = inProgress
                        }
                    Text(isTapped ? "Keep holding..." : "Hold to activate")
                        .foregroundStyle(Color.white)
                }
                
                Button(action: requestPermissions) {
                    Text("Request Permissions (testing)")
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(isTapped ? Color.blue : nil)
            .ignoresSafeArea()
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
