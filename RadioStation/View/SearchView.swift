//
//  search_button.swift
//  RadioStation
//
//  Created by Pantos, Thomas on 28/9/24.
//


import SwiftUI
import Foundation

import SwiftUI

struct SearchRadioView: View {
    
    @Binding var searchResults: RadioStation  // Use binding to pass results back
    @State private var searchText = ""   // Input text for the search
    
    @StateObject var vm = RadioStationViewModel()

    var body: some View {
        HStack {
            TextField("Search for radio...", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: searchText) { oldValue, newValue in
                    performSearch()
                }
        }
        .padding()
        
        .onAppear {
            if vm.radioStation.isEmpty {
                Task {
                    await vm.fetchData()
                }
            }
        }
    }
    
    private func performSearch() {
        if searchText.isEmpty {
            searchResults = []  // Clear results if search text is empty
        } else {
            searchResults = vm.radioStation.filter { radio in
                radio.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
