//
//  RightsDisplay.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.19.
//

import Foundation
import SwiftUI
import SwiftData

// TO-DO: write out the actual rights display data
// This is just a placeholder for the camera stuff

struct RightsDisplay: View {
    var startRecordingOnAppear: Bool
    
    @Environment(\.dismiss) var dismiss
    @State private var circleOpacity = 1.0
    
    @StateObject private var videoCaptureModel: VideoCaptureModel = VideoCaptureModel()
    
    @Environment(\.modelContext) var modelContext
    
    var repeatingAnimation: Animation {
            Animation
                .easeInOut(duration: 2) //.easeIn, .easyOut, .linear, etc...
                .repeatForever()
        }
    
    func saveAndStopRecording() {
        let recording = videoCaptureModel.stopRecording()
        if recording != nil {
            modelContext.insert(recording!)
        }
    }
    
    func toggleRecording() {
        print("Recording toggled")
        
        if videoCaptureModel.isRecording {
            saveAndStopRecording()
        } else {
            videoCaptureModel.startRecording()
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Know your rights when being pulled over or confronted by a police officer.")
                    .padding()
                
                GroupBox(label:
                    Label("You can...", systemImage: "checkmark")
                ) {
                    VStack(alignment: .leading) {
                        Label("Refuse to talk, make sure to tell the officer", systemImage: "checkmark")
                        Label("Say NO to the search of you, your car, and your house", systemImage: "checkmark")
                        Label("Leave once you have confirmed that you are not being detained", systemImage: "checkmark")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                
                Divider()
                
                GroupBox(label:
                    Label("You cannot...", systemImage: "xmark")
                ) {
                    VStack(alignment: .leading) {
                        Label("Refuse to show your driver's license", systemImage: "xmark")
                        Label("Refuse commands by an Officer during a stop", systemImage: "xmark")
                        Label("Refuse arrest", systemImage: "xmark")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                
                Divider()

                GroupBox(label:
                    Label("Do not...", systemImage: "exclamationmark.triangle")
                ) {
                    VStack(alignment: .leading) {
                        Label("Make abrupt motions", systemImage: "exclamationmark.triangle")
                        Label("Admit guilt", systemImage: "exclamationmark.triangle")
                        Label("Provide information that is not specifically requested", systemImage: "exclamationmark.triangle")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()

                
                Spacer()
            }
            .navigationTitle("Know Your Rights")
            .navigationBarBackButtonHidden(startRecordingOnAppear)
            .navigationBarTitleDisplayMode(.large)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .toolbar {
            if startRecordingOnAppear {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        // Save the video and exit the view
                        saveAndStopRecording()
                        dismiss()
                    } label: {
                        Text("Stop Recording and Exit")
                            .foregroundStyle(Color.red)
                    }
                }
            }
            
            if videoCaptureModel.isRecording {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Text("REC")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(.red)
                            .opacity(circleOpacity)
                            .onAppear {
                                withAnimation(repeatingAnimation) {
                                    if self.circleOpacity == 1.0 {
                                        self.circleOpacity = 0.4
                                    } else {
                                        self.circleOpacity = 1.0
                                    }
                                }
                            }
                    }
                }
            }
            
//            ToolbarItem(placement: .topBarTrailing) {
//                Button(action: toggleRecording) {
//                    Text(videoCaptureModel.isRecording ? "Pause Recording" : "Resume Recording")
//                }
//            }
        }
        .onAppear {
            if startRecordingOnAppear {
                videoCaptureModel.startRecording()
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
    
    return RightsDisplay(startRecordingOnAppear: false)
        .modelContainer(modelContainer)
}
