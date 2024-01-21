//
//  RecordingsView.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.20.
//

import Foundation
import SwiftUI
import SwiftData

/// View which displays all past recordings.
struct RecordingsView: View {
    var body: some View {
        List {
            Text("Hello")
        }
        .navigationTitle("Past Recordings")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    let schema = Schema([
        Recording.self,
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

    let modelContainer = try! ModelContainer(for: schema, configurations: [modelConfiguration])
    
    return RecordingsView()
        .modelContainer(modelContainer)
}

