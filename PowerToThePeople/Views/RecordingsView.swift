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
    @Query var recordings: [Recording]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        List {
            ForEach(recordings) { recording in
                NavigationLink {
                    RecordingView(recording: recording)
                } label: {
                    Text(recording.timestampEndedString)
                }
            }
            .onDelete(perform: deleteRecording)
        }
        .navigationTitle("Past Recordings")
        .navigationBarTitleDisplayMode(.large)
    }
    
    func deleteRecording(_ indexSet: IndexSet) {
        for index in indexSet {
            let recording = recordings[index]
            
            defer {
                // Otherwise, fail silently
                modelContext.delete(recording)
            }
            
            // Attempt to delete the recordings from the filesystem
            do {
                try FileManager.default.removeItem(at: recording.backCameraFile)
                try FileManager.default.removeItem(at: recording.frontCameraFile)
            } catch {
                print("Unable to delete recording: \(error)")
            }
        }
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

