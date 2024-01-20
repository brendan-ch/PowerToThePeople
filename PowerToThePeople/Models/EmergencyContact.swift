//
//  EmergencyContact.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.20.
//

import Foundation
import SwiftData

@Model
final class EmergencyContact {
    var name: String
    var phoneNumber: String
    var message: String
    
    init(name: String, phoneNumber: String, message: String) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.message = message
    }
}
