//
//  RightsDisplay.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.19.
//

import Foundation
import SwiftUI

// TO-DO: write out the actual rights display data
// This is just a placeholder for the camera stuff

struct RightsDisplay: View {
    func toggleRecording() {
        print("Recording toggled")
    }
    
    var body: some View {
        Button(action: toggleRecording) {
            Text("Toggle Recording")
        }
    }
}

#Preview {
    RightsDisplay()
}
