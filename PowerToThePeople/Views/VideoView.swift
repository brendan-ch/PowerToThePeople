//
//  VideoView.swift
//  PowerToThePeople
//
//  Created by Brendan Chen on 2024.01.20.
//

import Foundation
import SwiftUI
import AVFoundation
import AVKit

/// View which displays a video player.
struct VideoView: View {
    let videoUrl: URL
    @State private var videoPlayer: AVPlayer?
    
    var body: some View {
        VStack {
            if videoPlayer != nil {
                VideoPlayer(player: videoPlayer)
            }
        }
        .onAppear {
            let playerItem = AVPlayerItem(url: videoUrl)
            videoPlayer = AVPlayer(playerItem: playerItem)
        }
        .ignoresSafeArea()
        .backgroundStyle(.black)
    }
}

#Preview {
    VideoView(videoUrl: Bundle.main.url(forResource: "back", withExtension: "mov")!)
}
