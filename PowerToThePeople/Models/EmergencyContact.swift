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
    var name: String
    var phoneNumber: PhoneNumber?
    var message: String
    
    init(name: String, message: String) {
        self.name = name
        self.message = message
    }
}
