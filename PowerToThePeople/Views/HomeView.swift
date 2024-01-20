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
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Circle()
                        .frame(width: 200, height: 200)
                        .foregroundStyle(Color.blue)
                    Text("Hold to activate")
                        .foregroundStyle(Color.white)
                }
                
                NavigationLink {
                    RightsDisplay()
                } label: {
                    Text("Rights Display")
                }
                
                Button(action: requestPermissions) {
                    Text("Request Permissions")
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
