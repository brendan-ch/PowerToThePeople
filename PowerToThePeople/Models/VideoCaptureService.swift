//
//  VideoCaptureService.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.20.
//

import Foundation
import AVFoundation

// TO-DO: ensure both cameras are recording
// by inspecting output files

class VideoCaptureService: NSObject {
    private let captureSession = AVCaptureMultiCamSession()
    private var videoOutput = AVCaptureMovieFileOutput()
    
    /// Determines whether the video capture manager was successfully initialized.
    /// Accounts for scenarios where the user may not have given app permissions.
    private var initialized = false
    
    /// Whether the user has granted capture permissions to the app.
    var isAuthorized: Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        // Determine if the user previously authorized camera access.
        var isAuthorized = status == .authorized
        
        return isAuthorized
    }
    
    var isRecording: Bool {
        return captureSession.isRunning
    }
    
    override init() {
        super.init()
        performSetup()
    }
    
    static func attemptAuthorization() {
        Task.init {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            if status == .notDetermined {
                // Attempt to authorize video capture
                await AVCaptureDevice.requestAccess(for: .video)
            }
        }
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
        
        initialized = true
        captureSession.commitConfiguration()
    }
    
    func startRecording(to url: URL) {
        guard !videoOutput.isRecording else { return }
        
        // Avoid UI hangs
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
            self.videoOutput.startRecording(to: url, recordingDelegate: self)
        }

    }

    func stopRecording() {
        guard videoOutput.isRecording else { return }
        videoOutput.stopRecording()
        captureSession.stopRunning()
    }
}

extension VideoCaptureService: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput,
                    didFinishRecordingTo outputFileURL: URL,
                    from connections: [AVCaptureConnection],
                    error: Error?) {
        // Handle the end of recording
        if let error = error {
            print("Error recording video: \(error.localizedDescription)")
            
            // Force the capture session to stop
            captureSession.stopRunning()
        } else {
            // Video recording is finished, do something with the file at outputFileURL
            print("Video recording finished")
        }
    }
}
