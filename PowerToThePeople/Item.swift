//
//  Item.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.19.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
