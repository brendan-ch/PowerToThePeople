//
//  PowerToThePeopleApp.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.19.
//

import SwiftUI
import SwiftData

@main
struct PowerToThePeopleApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Recording.self,
            EmergencyContact.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                let setupCompleted = UserDefaults.standard.bool(forKey: "setupCompleted")
                
                if setupCompleted {
                    HomeView()
                } else {
                    IntroductionView()
                }
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
