//
//  IntroductionView.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.20.
//

import Foundation
import SwiftUI

struct IntroductionView: View {
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            Text("Power to the People")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("A CruzHacks 2024 project by Brendan, David, Jacob, and Patrick")
                .multilineTextAlignment(.center)
            Spacer()
            
            Button {} label: {
                Text("Set up")
                    .fontWeight(.bold)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 2)
            }
            .padding()
        }
    }
}

#Preview {
    IntroductionView()
}
