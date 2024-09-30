//
//  TabView.swift
//  RadioStation
//
//  Created by Pantos, Thomas on 29/9/24.
//

import SwiftUI

import SwiftUI

struct MainTabView: View {
    @StateObject var favourites = Favourites() // Create Favourites as a StateObject

    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Radios", systemImage: "radio")
                }
            FavouritesView()
                .tabItem {
                    Label("Favourites", systemImage: "heart")
                }
        }
        .environmentObject(favourites) // Pass favourites to the environment
    }
}
