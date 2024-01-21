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
    
    // TO-DO: generate the thumbnails
    @State private var frontThumbnail: UIImage?
    @State private var backThumbnail: UIImage?
    
    var body: some View {
        VStack {
            ZStack {
                if backThumbnail != nil {
                    Image(uiImage: backThumbnail!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 500)
                        .clipped()
                }
                
                if frontThumbnail != nil {
                    Image(uiImage: frontThumbnail!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 128, maxHeight: 200)
                        .clipped()
                        .position(x: 80, y: 374)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 500)
            .padding()
            Text("TO-DO: info + video playback")
            Spacer()
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
