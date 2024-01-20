//
//  ContactsView.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.20.
//

import Foundation
import SwiftUI

/// View for editing emergency contacts.
struct ContactsView: View {
    var body: some View {
        VStack {
            Text("Add emergency contacts to notify when you activate recording.")
        }
        .navigationTitle("Emergency Contacts")
    }
}

#Preview {
    ContactsView()
}
