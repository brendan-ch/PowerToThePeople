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
    /// Capture session for both cameras and the microphone.
    private let captureSession = AVCaptureMultiCamSession()
    
    /// The video output for the back camera.
    private let videoOutputBack = AVCaptureMovieFileOutput()
    
    /// The video output for the front camera.
    private let videoOutputFront = AVCaptureMovieFileOutput()
    
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
    
    /// Indicates whether the capture session is running.
    var isRecording: Bool {
        return captureSession.isRunning
    }
    
    override init() {
        super.init()
        performSetup()
    }
    
    /// Attempt to request authorization for the camera.
    static func attemptAuthorization() {
        Task.init {
            let videoStatus = AVCaptureDevice.authorizationStatus(for: .video)
            if videoStatus == .notDetermined {
                // Attempt to authorize video capture
                await AVCaptureDevice.requestAccess(for: .video)
            }
            
            let microphoneStatus = AVCaptureDevice.authorizationStatus(for: .audio)
            if microphoneStatus == .notDetermined {
                await AVCaptureDevice.requestAccess(for: .audio)
            }
        }
    }
    
    /// Perform video capture setup for the front and back cameras, and the microphone.
    func performSetup() {
        captureSession.beginConfiguration()
        
        // TO-DO: utilize the default back camera as a fallback for older phones
        guard let videoDeviceFront = AVCaptureDevice.default(.builtInUltraWideCamera, for: .video, position: .back) else {
            print("Unable to get front video device")
            return
        }
        guard let videoDeviceBack = AVCaptureDevice.default(.builtInTrueDepthCamera, for: .video, position: .front) else {
            print("Unable to get back video device")
            return
        }
        
        guard let microphoneDevice = AVCaptureDevice.default(for: .audio) else {
            print("Unable to get microphone device")
            return
        }
        
        // Set up video input
        if let videoInputFront = try? AVCaptureDeviceInput(device: videoDeviceFront),
           let videoInputBack = try? AVCaptureDeviceInput(device: videoDeviceBack),
           let microphoneInput = try? AVCaptureDeviceInput(device: microphoneDevice),
           captureSession.canAddInput(videoInputFront) && captureSession.canAddInput(videoInputBack)
        {
            captureSession.addInput(videoInputFront)
            captureSession.addInput(videoInputBack)
            captureSession.addInput(microphoneInput)
        } else {
            print("Unable to add video inputs to capture session")
            return
        }

        // Set up video output
        if captureSession.canAddOutput(videoOutputBack) {
            captureSession.addOutput(videoOutputBack)
        }
        if captureSession.canAddOutput(videoOutputFront) {
            captureSession.addOutput(videoOutputFront)
        }
        
        initialized = true
        captureSession.commitConfiguration()
    }
    
    /// Start recording video.
    /// @param toFront The URL to write to for the front camera.
    /// @param toBack the URL to write to for the back camera.
    /// @param completion Completion handler determining whether video capture was started successfully.
    func startRecording(toFront videoUrlFront: URL, toBack videoUrlBack: URL, completion: @escaping (Bool) -> Void) {
        guard !videoOutputFront.isRecording else { return }
        guard !videoOutputBack.isRecording else { return }
        
        // Avoid UI hangs by starting the camera in the background
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
            self.videoOutputFront.startRecording(to: videoUrlFront, recordingDelegate: self)
            self.videoOutputBack.startRecording(to: videoUrlBack, recordingDelegate: self)
            
            // CAVEAT: doesn't account for capture session stops due to saving error
            completion(true)
        }

    }

    /// Stop recording all video, and stop the capture
    /// @param completion Completion handler determining whether video capture was stopped successfully.
    func stopRecording(completion: @escaping (Bool) -> Void) {
        guard videoOutputFront.isRecording else { return }
        guard videoOutputBack.isRecording else { return }
        
        DispatchQueue.global(qos: .background).async {
            self.videoOutputFront.stopRecording()
            self.videoOutputBack.stopRecording()
            self.captureSession.stopRunning()
            completion(true)
        }
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
