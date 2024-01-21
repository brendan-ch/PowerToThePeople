//
//  Recording.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.19.
//

import Foundation
import SwiftData
import CoreLocation

@Model
final class Recording {
    /// Location of the video recording from the back camera (facing away from the user).
    let backCameraFile: URL
    
    /// Location of the video recording from the front camera.
    let frontCameraFile: URL
    
    /// The timestamp that the recording was started.
    let timestampStarted: Date
    
    /// The timestamp that the recording was ended.
    let timestampEnded: Date
    
    var timestampEndedString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.DD HH:mm:ss"
        
        return dateFormatter.string(from: timestampEnded)
    }
    
    /// Latitude of the location that the recording was taken.
    let locationLatitude: Int32?
    
    /// Longitude of the location that the recording was taken.
    let locationLongitude: Int32?
    
    /// Any notes added by the user.
    let notes: String
    
    init(backCameraFile: URL, frontCameraFile: URL, timestampStarted: Date, timestampEnded: Date, notes: String) {
        self.backCameraFile = backCameraFile
        self.frontCameraFile = frontCameraFile
        self.timestampStarted = timestampStarted
        self.timestampEnded = timestampEnded
        self.notes = notes
    }
    
    init(backCameraFile: URL, frontCameraFile: URL, timestampStarted: Date, timestampEnded: Date, locationLatitude: Int32, locationLongitude: Int32, notes: String) {
        self.backCameraFile = backCameraFile
        self.frontCameraFile = frontCameraFile
        self.timestampStarted = timestampStarted
        self.timestampEnded = timestampEnded
        self.locationLatitude = locationLatitude
        self.locationLongitude = locationLongitude
        self.notes = notes
    }
}
