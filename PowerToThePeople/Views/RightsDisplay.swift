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
    @State private var recording: Bool = false
    
    func toggleRecording() {
        print("Recording toggled")
        recording = !recording
    }
    
    var body: some View {
        Button(action: toggleRecording) {
            if recording {
                Text("Stop Recording")
            } else {
                Text("Start Recording")
            }
        }
    }
}

#Preview {
    RightsDisplay()
}
