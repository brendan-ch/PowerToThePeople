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
            // Create a new folder with the current timestamp
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY.MM.DD HH.mm.ss"
            let now = Date.now
            let dateStr = dateFormatter.string(from: now)
            
            let saveDirectory = URL.documentsDirectory.appendingPathComponent(dateStr)
            
            do {
                try FileManager.default.createDirectory(at: saveDirectory, withIntermediateDirectories: true)
                
                videoCaptureViewModel.startRecording(toFolder: saveDirectory)
            } catch {
                print("Unable to create folder/start video recording: \(error)")
            }
        }
    }
    
    var body: some View {
        Button(action: toggleRecording) {
            if videoCaptureViewModel.isRecording {
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
