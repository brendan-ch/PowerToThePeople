//
//  ContactView.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.20.
//

import Foundation
import SwiftUI

struct ContactView: View {
    @Bindable var contact: EmergencyContact
    
    var body: some View {
        Form {
            Section(header: Text("Contact")) {
                TextField("Name", text: $contact.name)
                TextField("Phone number", text: .constant(""))
                    .textContentType(.telephoneNumber)
                    .keyboardType(.phonePad)
                TextField("Message", text: $contact.name, axis: .vertical)
                    .lineLimit(4, reservesSpace: true)
            }
        }
    }
}

#Preview {
    ContactView(contact: EmergencyContact(name: "Test Contact", message: "Test Message"))
}
