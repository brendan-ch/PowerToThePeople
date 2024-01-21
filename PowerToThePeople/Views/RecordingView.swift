//
//  RecordingView.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.20.
//

import Foundation
import SwiftUI
import AVFoundation
import AVKit

struct RecordingView: View {
    let recording: Recording
    
    @State private var frontThumbnail: UIImage?
    @State private var backThumbnail: UIImage?
    
    @State private var backThumbnailVideoPresented = false
    @State private var frontThumbnailVideoPresented = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                ZStack {
                    if backThumbnail != nil {
                        Image(uiImage: backThumbnail!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: 500)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .onTapGesture {
                                backThumbnailVideoPresented = true
                            }
                    }
                    
                    if frontThumbnail != nil {
                        Image(uiImage: frontThumbnail!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 128, maxHeight: 200)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .position(x: 80, y: 374)
                            .onTapGesture {
                                frontThumbnailVideoPresented = true
                            }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 500)
                .padding()
                .sheet(isPresented: $frontThumbnailVideoPresented) {
                    VideoView(videoUrl: recording.frontCameraFile)
                }
                .sheet(isPresented: $backThumbnailVideoPresented) {
                    VideoView(videoUrl: recording.backCameraFile)
                }
                
                Text("Recorded \(recording.timestampEndedString)")
                    .foregroundStyle(.secondary)
                
                Spacer()
            }
        }
        .onAppear {
            withAnimation {
                backThumbnail = generateThumbnail(path: recording.backCameraFile)
                frontThumbnail = generateThumbnail(path: recording.frontCameraFile)
            }
        }
        
    }
    
    private func generateThumbnail(path: URL) -> UIImage? {
        do {
            let asset = AVURLAsset(url: path)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            return thumbnail
        } catch {
            print("Error generating thumbnail: \(error)")
            return nil
        }
    }
}

#Preview {
    let recording = Recording(backCameraFile: Bundle.main.url(forResource: "back", withExtension: "mov")!, frontCameraFile: Bundle.main.url(forResource: "front", withExtension: "mov")!, timestampStarted: Date.now, timestampEnded: Date.now, notes: "")
    
    return RecordingView(recording: recording)
}
