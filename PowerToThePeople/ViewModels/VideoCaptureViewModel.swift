//
//  VideoCaptureViewModel.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.20.
//

import Foundation

/// View model which exposes isRecording and error messages to observers.
class VideoCaptureViewModel: ObservableObject {
    private let service: VideoCaptureService = VideoCaptureService()
    
    @Published var isRecording = false
    @Published var error: Error?
    
    func startRecording() {
        defer {
            isRecording = service.isRecording
        }
        
        // Create a new folder with the current timestamp
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.DD HH.mm.ss"
        let now = Date.now
        let dateStr = dateFormatter.string(from: now)
        
        let saveDirectory = URL.documentsDirectory.appendingPathComponent(dateStr)
        
        do {
            try FileManager.default.createDirectory(at: saveDirectory, withIntermediateDirectories: true)
            
            service.startRecording(toFront: saveDirectory.appendingPathComponent("front.mov"), toBack: saveDirectory.appendingPathComponent("back.mov"))
        } catch {
            print("Unable to create folder/start video recording: \(error)")
        }
    }
    
    func stopRecording() {
        service.stopRecording()
        
        isRecording = service.isRecording
    }
}
