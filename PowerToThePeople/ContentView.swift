//
//  ContentView.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.19.
//

import SwiftUI
import SwiftData

// TO-DO
// SwiftData data specs - IN PROGRESS
// Front and back recording, permissions - NOT STARTED
// File storage + organization - NOT STARTED
// Display video files - NOT STARTED

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            List {
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        // Stub from demo
    }

    private func deleteItems(offsets: IndexSet) {
        // Stub from demo
    }
}

#Preview {
    ContentView()
}
