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
                Text("Know Your Rights")
            }
            .navigationTitle("Know Your Rights")
            .navigationBarTitleDisplayMode(.large)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
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
