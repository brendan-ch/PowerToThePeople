//
//  ContactsView.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.20.
//

import Foundation
import SwiftData
import PhoneNumberKit
import SwiftUI

/// View for editing emergency contacts.
struct ContactsView: View {
    let phoneNumberKit = PhoneNumberKit()
    @Query var contacts: [EmergencyContact]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            List {
                ForEach(contacts) { contact in
                    NavigationLink {
                        ContactView(contact: contact)
                    } label: {
                        contact.name == "" ? Text("New Contact") : Text(contact.name)
                    }
                }
                
                Button(action: addContact) {
                    Text("Add Emergency Contact")
                }
            }
        }
        .navigationTitle("Emergency Contacts")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func addContact() {
        withAnimation {
            let newContact = EmergencyContact(name: "", message: "")
            
            modelContext.insert(newContact)
        }
    }
}

#Preview {
    let schema = Schema([
        EmergencyContact.self,
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

    let modelContainer = try! ModelContainer(for: schema, configurations: [modelConfiguration])
    
    return ContactsView()
        .modelContainer(modelContainer)
}
