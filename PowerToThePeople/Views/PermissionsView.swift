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
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                Text("Permissions Setup")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Power to the People needs the following permissions to work.")
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 8) {
                    Button {} label: {
                        Text("Request camera access")
                            .fontWeight(.bold)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    Text("We use the front and back camera to record interactions with police.")
                        .multilineTextAlignment(.center)
                }
                .padding(.vertical)
                
                VStack(spacing: 8) {
                    Button {} label: {
                        Text("Request microphone access")
                            .fontWeight(.bold)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    Text("We use the microphone to record interactions with police.")
                        .multilineTextAlignment(.center)
                }
                .padding(.vertical)
                
                VStack(spacing: 8) {
                    Button {} label: {
                        Text("Request location access (optional)")
                            .fontWeight(.bold)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    Text("If enabled, your videos will have location data associated with them.")
                        .multilineTextAlignment(.center)
                }
                .padding(.vertical)

                Spacer()
                Button {} label: {
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
        
    }
}

#Preview {
    PermissionsView()
}
