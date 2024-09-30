//
//  RadioStationApp.swift
//  RadioStation
//
//  Created by Pantos, Thomas on 28/9/24.
//

import SwiftUI

@main
struct RadioStationApp: App {
//    let persistenceController = PersistenceController.shared
    @StateObject private var favourites = Favourites()
    
    var body: some Scene {
        WindowGroup {
            MainTabView(favourites: favourites )
                
            
        }
    }
}
