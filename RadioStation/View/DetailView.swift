//
//  DetailView.swift
//  RadioStation
//
//  Created by Pantos, Thomas on 28/9/24.
//

import SwiftUI

struct DetailView: View {
    @State var radio: RadioStationElement
    @EnvironmentObject var favourites: Favourites 
    var body: some View {
        VStack {
            Text(radio.title)
                .font(.largeTitle)
                .padding()

            let url = URL(string: radio.logo)
            ImageView(url: url)
                .frame(width: 150, height: 150)
                .clipShape(Circle())

            Button(action: toggleLikeStatus) {
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
        .navigationTitle("Detail")
    }

    private func toggleLikeStatus() {
        if favourites.contains(radio) {
            favourites.remove(radio)
        } else {
            favourites.add(radio)  // Add to favorites
            
        }
    }
}
