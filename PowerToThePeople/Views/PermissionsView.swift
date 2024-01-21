//
//  PermissionsView.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.20.
//

import Foundation
import SwiftUI

/// View for setting up user permissions.
struct PermissionsView: View {
    @State private var contactsViewPresented = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                Text("Permissions Setup")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Power to the People needs the following permissions to work.")
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 8) {
                    SetupButton(text: "Request camera + microphone access") {}
                    .padding(.horizontal)
                    Text("We use the front and back camera to record interactions with police.")
                        .multilineTextAlignment(.center)
                }
                .padding(.vertical)
                
                VStack(spacing: 8) {
                    SetupButton(text: "Request location access (optional)") {}
                    .padding(.horizontal)
                    Text("If enabled, your videos will have location data associated with them.")
                        .multilineTextAlignment(.center)
                }
                .padding(.vertical)

                Spacer()
                Button {
                    contactsViewPresented = true
                } label: {
                    Text("Continue")
                        .fontWeight(.bold)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .navigationDestination(isPresented: $contactsViewPresented) {
            ContactsSetup()
        }
        
    }
}

#Preview {
    PermissionsView()
}
