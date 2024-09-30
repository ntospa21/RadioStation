//
//  button_play.swift
//  RadioStation
//
//  Created by Pantos, Thomas on 28/9/24.
//

import SwiftUI
import AVFoundation

struct PlayButtonView: View {
    @State private var isPlaying = false
    let url: String
    @State var player: AVPlayer?

    var body: some View {
        VStack {
            Button(action: {
                isPlaying.toggle()
                             
                             if isPlaying {
                                 guard let url = URL(string: url) else { return }
                                 let playerItem = AVPlayerItem(url: url)
                                 self.player = AVPlayer(playerItem: playerItem)
                                 self.player?.play()
                             } else {
                                 self.player?.pause()
                                 self.player = nil  // Reset the player
                             }
                
                
            }) {
                
          
                
                Image(systemName: isPlaying ? "stop.fill" : "play.fill") // SF Symbols for play and stop
                    .resizable()
                    .frame(width: 50, height: 50)  // Set the size of the button
                    .foregroundColor(isPlaying ? .red : .green)  // Red for stop, green for play
            }
            .padding(20)  // Add padding around the button
            .background(Circle().fill(isPlaying ? Color.red.opacity(0.2) : Color.green.opacity(0.2))) // Circle background with opacity
            .overlay(Circle().stroke(isPlaying ? Color.red : Color.green, lineWidth: 3)) // Circle border

            // Display text indicating the current state
            Text(isPlaying ? "Stop" : "Play")
                .font(.headline)
                .padding(.top, 10)
        }
    }
}

