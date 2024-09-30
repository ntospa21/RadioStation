//
//  FavouritesView.swift
//  RadioStation
//
//  Created by Pantos, Thomas on 29/9/24.
//

import SwiftUI
import CoreData
struct FavouritesView: View {
    @EnvironmentObject var favourites: Favourites // Use @EnvironmentObject
    

    var body: some View {
        NavigationView {
            VStack {
                
            
                if favourites.favouriteRadioStations.isEmpty {
                    Text("No radio stations liked.")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(Array(favourites.favouriteRadioStations), id: \.id) { favorite in
                            HStack {
                                AsyncImage(url: URL(string: favorite.logo)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                } placeholder: {
                                    ProgressView()
                                }
                                Text(favorite.title) // Use title from the favorite station
                                    .padding()
                                    .font(.headline)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
            .padding()
        }
    }

}
