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
    
    func startRecording(toFolder url: URL) {
        service.startRecording(toFront: url.appendingPathComponent("front.mov"), toBack: url.appendingPathComponent("back.mov"))
        
        // TO-DO: read the property from the service
        isRecording = service.isRecording
    }
    
    func stopRecording() {
        service.stopRecording()
        
        isRecording = service.isRecording
    }
}
