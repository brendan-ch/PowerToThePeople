//
//  RightsDisplay.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.19.
//

import Foundation
import SwiftUI
import AVFoundation

// TO-DO: write out the actual rights display data
// This is just a placeholder for the camera stuff

struct RightsDisplay: View {
    @StateObject private var videoCaptureViewModel: VideoCaptureViewModel = VideoCaptureViewModel()
    
    func toggleRecording() {
        print("Recording toggled")
        
        if videoCaptureViewModel.isRecording {
            videoCaptureViewModel.stopRecording()
        } else {
            videoCaptureViewModel.startRecording()
        }
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                GroupBox(label:
                    Label("You can...", systemImage: "checkmark")
                ) {
                    VStack(alignment: .leading) {
                        Label("Refuse to talk, make sure to tell the officer", systemImage: "checkmark")
                        Label("Say NO to the search of you, your car, and your house", systemImage: "checkmark")
                        Label("Leave once you have confirmed that you are not being detained", systemImage: "checkmark")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                
                Divider()
                
                GroupBox(label:
                    Label("You cannot...", systemImage: "xmark")
                ) {
                    VStack(alignment: .leading) {
                        Label("Refuse to show your driver's license", systemImage: "xmark")
                        Label("Refuse commands by an Officer during a stop", systemImage: "xmark")
                        Label("Refuse arrest", systemImage: "xmark")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                
                Divider()

                GroupBox(label:
                    Label("Do not...", systemImage: "exclamationmark.triangle")
                ) {
                    VStack(alignment: .leading) {
                        Label("Make abrupt motions", systemImage: "exclamationmark.triangle")
                        Label("Admit guilt", systemImage: "exclamationmark.triangle")
                        Label("Provide information that is not specifically requested", systemImage: "exclamationmark.triangle")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()

                
                Spacer()
            }
            .navigationTitle("Know Your Rights")
            .navigationBarTitleDisplayMode(.large)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .toolbar {
            Button(action: toggleRecording) {
                Text(videoCaptureViewModel.isRecording ? "Pause Recording" : "Resume Recording")
            }
        }
    }
}

#Preview {
    RightsDisplay()
}
