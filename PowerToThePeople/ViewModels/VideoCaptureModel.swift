//
//  VideoCaptureViewModel.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.20.
//

import Foundation

/// View model which exposes isRecording and error messages to observers.
class VideoCaptureModel: ObservableObject {
    private let service: VideoCaptureService = VideoCaptureService()
    
    @Published var isRecording = false
    @Published var error: Error?
    
    /// Time the video started recording.
    private var timeStarted: Date?
    private var backCameraFile: URL?
    private var frontCameraFile: URL?
    
    /// Create video directory, start recording the video, and update the state.
    func startRecording() {
        timeStarted = nil
        backCameraFile = nil
        frontCameraFile = nil
        
        // Create a new folder with the current timestamp
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.DD HH.mm.ss"
        let now = Date.now
        let dateStr = dateFormatter.string(from: now)
        
        timeStarted = now
        
        let saveDirectory = URL.documentsDirectory.appendingPathComponent(dateStr)
        
        do {
            try FileManager.default.createDirectory(at: saveDirectory, withIntermediateDirectories: true)
            
            backCameraFile = saveDirectory.appendingPathComponent("back.mov")
            frontCameraFile = saveDirectory.appendingPathComponent("front.mov")
            
            service.startRecording(toFront: frontCameraFile!, toBack: backCameraFile!) { [weak self] started in
                // Use completion handler to update state
                DispatchQueue.main.async {
                    self?.isRecording = started
                }
            }
        } catch {
            print("Unable to create folder/start video recording: \(error)")
        }
    }
    
    /// Stop the recording and update the state.
    /// Returns a Recording object which can be saved to SwiftData.
    func stopRecording() -> Recording? {
        service.stopRecording() { [weak self] finished in
            DispatchQueue.main.async {
                self?.isRecording = !finished
            }
        }
        
        guard backCameraFile != nil, frontCameraFile != nil, timeStarted != nil else {
            print("Couldn't save recording; parameter missing")
            return nil
        }
        
        let recording = Recording(backCameraFile: backCameraFile!, frontCameraFile: frontCameraFile!, timestampStarted: timeStarted!, timestampEnded: Date.now, notes: "")
        return recording
    }
}
