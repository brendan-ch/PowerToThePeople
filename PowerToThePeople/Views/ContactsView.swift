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
        VStack(alignment: .leading, spacing: 16) {
            Form {
                Section(header: Text("Contact #1")) {
                    TextField("Name", text: .constant(""))
                    TextField("Phone number", text: .constant(""))
                        .textContentType(.telephoneNumber)
                        .keyboardType(.phonePad)
                    TextField("Message", text: .constant(""), axis: .vertical)
                        .lineLimit(4, reservesSpace: true)
                }
                
                Section(header: Text("Contact #2")) {
                    TextField("Name", text: .constant(""))
                    TextField("Phone number", text: .constant(""))
                        .textContentType(.telephoneNumber)
                        .keyboardType(.phonePad)
                    TextField("Message", text: .constant(""), axis: .vertical)
                        .lineLimit(4, reservesSpace: true)
                }
                
                Button {} label: {
                    Text("Clear Emergency Contacts")
                        .foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("Emergency Contacts")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContactsView()
}
