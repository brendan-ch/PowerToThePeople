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

/// Handles the capturing of video from the front and back cameras.
class VideoCaptureManager: NSObject {
    private let captureSession = AVCaptureMultiCamSession()
    private var videoOutput = AVCaptureMovieFileOutput()
    
    /// Determines whether the video capture manager was successfully initialized.
    /// Accounts for scenarios where the user may not have given app permissions.
    private var initialized = false
    
    override init() {
        super.init()
        performSetup()
    }
    
    func performSetup() {
        captureSession.beginConfiguration()
        
        // Set up video input
        if let videoDevice = AVCaptureDevice.default(for: .video),
           let videoInput = try? AVCaptureDeviceInput(device: videoDevice),
           captureSession.canAddInput(videoInput) {
                captureSession.addInput(videoInput)
           }

        // Set up video output
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        }
        
        captureSession.commitConfiguration()
    }
    
    func startRecording() {
        guard !videoOutput.isRecording else { return }

        let outputPath = NSTemporaryDirectory() + "output.mov"
        let outputFileURL = URL(fileURLWithPath: outputPath)
        videoOutput.startRecording(to: outputFileURL, recordingDelegate: self)
    }

    func stopRecording() {
        guard videoOutput.isRecording else { return }
        videoOutput.stopRecording()
    }
}

extension VideoCaptureManager: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput,
                    didFinishRecordingTo outputFileURL: URL,
                    from connections: [AVCaptureConnection],
                    error: Error?) {
        // Handle the end of recording
        if let error = error {
            print("Error recording video: \(error.localizedDescription)")
        } else {
            // Video recording is finished, do something with the file at outputFileURL
        }
    }
}

struct RightsDisplay: View {
    @State private var recording: Bool = false
    private let videoCaptureManager: VideoCaptureManager = VideoCaptureManager()
    
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
