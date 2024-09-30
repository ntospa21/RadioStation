//
//  ContentView.swift
//  RadioStation
//
//  Created by Pantos, Thomas on 28/9/24.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @StateObject var vm = RadioStationViewModel()
    @StateObject var networkMonitor = NetworkMonitor()
    @StateObject var favourites = Favourites()  // Instantiate Favourites here

    var body: some View {
        NavigationView {
            VStack {
                Text("Radio Stations").font(.largeTitle).padding()

                if networkMonitor.isConnected {
                    List {
                        ForEach(vm.radioStation) { radio in
                            HStack {
                                RowView(radio: radio)
                                NavigationLink(destination: DetailView(radio: radio)) { // Pass favourites to DetailView
                                    EmptyView()
                                }
                                .opacity(0)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .onAppear {
                        Task {
                            await vm.fetchData() // Fetch data when connected
                        }
                    }
                } else {
                    Text("Offline version")
                    List(vm.savedRadioStation) { radio in
                        NavigationLink(destination: DetailView(radio: radio)) { // Pass favourites to DetailView
                            HStack {
                                let url = URL(string: radio.logo)
                                ImageView2(withURL: radio.logo)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                Text("\(radio.title)")
                                    .padding()
                                    .font(.title)
                            }
                        }
                    }
                    .onAppear {
                        vm.loadData() // Load local data when offline
                    }
                }
            }
            .navigationTitle("Radio Stations")
        }
        .environmentObject(favourites) // Inject Favourites into the environment
    }
}

#Preview {
    ContentView()
}
