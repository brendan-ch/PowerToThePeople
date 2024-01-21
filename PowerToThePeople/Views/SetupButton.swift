//
//  SetupButton.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.20.
//

import Foundation
import SwiftUI

struct SetupButton: View {
    var text: String
    var action: () -> Void
    var disabled: Bool?
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .fontWeight(.bold)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
        }
        .disabled(disabled ?? false)
    }
}
