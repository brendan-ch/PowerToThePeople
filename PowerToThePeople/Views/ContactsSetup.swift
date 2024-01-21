//
//  File.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.20.
//

import Foundation
import SwiftUI

struct ContactsSetup: View {
    @State private var homePageDisplayed = false
    
    var body: some View {
        VStack(spacing: 8) {
            ContactsView()
            
            SetupButton(text: "Next") {
                UserDefaults.standard.setValue(true, forKey: "setupCompleted")
                homePageDisplayed = true
            }
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .navigationDestination(isPresented: $homePageDisplayed) {
            HomeView()
        }
    }
}


#Preview {
    ContactsSetup()
}
