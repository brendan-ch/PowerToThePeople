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
    
    /// Create video directory, start recording the video, and update the state.
    func startRecording() {
        // Create a new folder with the current timestamp
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.DD HH.mm.ss"
        let now = Date.now
        let dateStr = dateFormatter.string(from: now)
        
        let saveDirectory = URL.documentsDirectory.appendingPathComponent(dateStr)
        
        do {
            try FileManager.default.createDirectory(at: saveDirectory, withIntermediateDirectories: true)
            
            service.startRecording(toFront: saveDirectory.appendingPathComponent("front.mov"), toBack: saveDirectory.appendingPathComponent("back.mov")) { [weak self] started in
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
    func stopRecording() {
        service.stopRecording() { [weak self] finished in
            DispatchQueue.main.async {
                self?.isRecording = !finished
            }
        }
    }
}
