//
//  DetailView.swift
//  RadioStation
//
//  Created by Pantos, Thomas on 28/9/24.
//

import SwiftUI

struct DetailView: View {
    @State var radio: RadioStationElement  // Radio station passed from ContentView
    @EnvironmentObject var favourites: Favourites  // Use @EnvironmentObject to access the shared Favourites instance

    var body: some View {
        VStack {
            Text(radio.title)
                .font(.largeTitle)
                .padding()

            let url = URL(string: radio.logo)
            ImageView(url: url)
                .frame(width: 150, height: 150)
                .clipShape(Circle())  // Larger circular image

            // Button for toggling like status
            Button(action: toggleLikeStatus) {
                // Check if the station is already in favorites
                Image(systemName: favourites.contains(radio) ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(favourites.contains(radio) ? .red : .primary)  // Red if liked, primary color if not
            }
            .padding(20)
            .padding(.trailing)
            .frame(maxWidth: .infinity, alignment: .trailing)

            Text(radio.description)
                .padding()

            Spacer()
            
            let audioUrl = radio.streamingURL
            HStack {
                PlayButtonView(url: audioUrl)
            }
        }
        .navigationTitle("Details")
    }

    // Toggle the like status of the radio station
    private func toggleLikeStatus() {
        if favourites.contains(radio) {
            favourites.remove(radio)
            radio.isLiked = false
        } else {
            favourites.add(radio)  // Add to favorites
            
            radio.isLiked = true
        }
    }
}
