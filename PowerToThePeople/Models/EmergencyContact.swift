//
//  EmergencyContact.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.20.
//

import Foundation
import SwiftData
import PhoneNumberKit

@Model
final class EmergencyContact {
    let name: String
    let phoneNumber: PhoneNumber
    let message: String
    
    init(name: String, phoneNumber: PhoneNumber, message: String) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.message = message
    }
}
