//
//  IntroductionView.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.20.
//

import Foundation
import SwiftUI

struct IntroductionView: View {
    @State private var permissionsViewPresented = false
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            Text("Power to the People")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("A CruzHacks 2024 project by Brendan, David, Jacob, and Patrick")
                .multilineTextAlignment(.center)
            Spacer()
            
            SetupButton(text: "Continue") {
                print("Button pressed")
                permissionsViewPresented = true
            }
            .padding()
        }
        .navigationDestination(isPresented: $permissionsViewPresented) {
            PermissionsView()
        }
    }
}

#Preview {
    IntroductionView()
}
