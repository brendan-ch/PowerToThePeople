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
    
    @State private var contactViewPresented = false
    
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
                .onDelete(perform: deleteContacts)
                
                Button(action: addContact) {
                    Text("Add Emergency Contact")
                }
            }
            
        }
        .navigationTitle("Emergency Contacts")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationDestination(isPresented: $contactViewPresented) {
            if contacts.count > 0 {
                ContactView(contact: contacts[contacts.count - 1])
            }
        }
    }
    
    func addContact() {
        withAnimation {
            let newContact = EmergencyContact(name: "", message: "")
            
            modelContext.insert(newContact)
            contactViewPresented = true
        }
    }
    
    func deleteContacts(_ indexSet: IndexSet) {
        for index in indexSet {
            let contact = contacts[index]
            modelContext.delete(contact)
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
