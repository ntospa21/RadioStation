//
//  client_services.swift
//  RadioStation
//
//  Created by Pantos, Thomas on 28/9/24.
//

import Foundation
import Combine
import Swift



@MainActor
class RadioStationViewModel: ObservableObject {
    
    @Published var radioStation = RadioStation() // This holds the currently fetched radio stations.
    @Published var savedRadioStation: RadioStation = [] // This holds the saved radio stations from UserDefaults.
    @Published var favStation : RadioStation = []
    
    let userDefaults = UserDefaults.standard
    let url = "https://www.3ds.gr/apptest/stations.json"

    init() {
        loadData()  // Load saved data when initializing
    }

    func fetchData() async {
        guard let downloadedRadioStations: RadioStation = await WebService().downloadData(fromURL: url) else { return }
        radioStation = downloadedRadioStations
        
        // Optionally, you can save the downloaded stations directly to UserDefaults.
        saveData(radioStations: downloadedRadioStations)
        
        print("Fetched stations: \(radioStation)")
    }

    func saveData(radioStations: RadioStation) {
        // Encode the radioStations to JSON and save it in UserDefaults
        if let encodedData = try? JSONEncoder().encode(radioStations) {
            userDefaults.set(encodedData, forKey: "savedRadioStation")
            print("Saved stations to UserDefaults.")
            print(" Endoded data : \(encodedData)")

        }
    }

    func loadData() {
        // Retrieve the data from UserDefaults and decode it
        if let savedData = userDefaults.data(forKey: "savedRadioStation"),
           let decodedStations = try? JSONDecoder().decode(RadioStation.self, from: savedData) {
            savedRadioStation = decodedStations
            print("Loaded stations from UserDefaults: \(savedRadioStation)")
        } else {
            print("No saved stations found.")
        }
    }
    
    func contains(_ station: RadioStationElement) -> Bool {
        favStation.contains(station)
    }

    func add(_ station: RadioStationElement) {
        favStation.append(station)
        objectWillChange.send()
        print("added 1 station to favourites\(favStation.count)")
    }

    // Remove a station from favorites
      func remove(_ station: RadioStationElement) {
          if let index = favStation.firstIndex(where: { $0.id == station.id }) {
              favStation.remove(at: index)
              print("Removed 1 station from favorites. Total: \(favStation.count)")
          }
      }

    func getFavorites() -> [RadioStationElement] {
        return favStation // Convert set to array
    }

}

@MainActor class SavedRadioStationViewModel: ObservableObject {
    
    
    @Published var favouriteStation : RadioStation = []
    var url = "https://www.3ds.gr/apptest/stations.json"

    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("https://www.3ds.gr/apptest/stations.json")
        
    }
    func load() async throws {
        let task = Task<RadioStation, Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let localRadioStation = try JSONDecoder().decode(RadioStation.self, from: data)
            return localRadioStation
        }
        let savedRadioStation = try await task.value
        self.favouriteStation = savedRadioStation
        print("Saved are \(savedRadioStation)")
    }
    
    func save(locallyStation: RadioStation) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(locallyStation)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
            
        }
        _ = try await task.value
    }
    



}


@MainActor
class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, self != nil else { return }
            DispatchQueue.main.async { [ self]
                self?.data = data
            }
        }
        task.resume()
    }
}



@MainActor
class Favourites: ObservableObject {
    @Published private(set) var favouriteRadioStations: Set<RadioStationElement>
    private let saveKey = "Favourites"

    init() {
        favouriteRadioStations = [] // Initialize with an empty set
        load()
    }

    func contains(_ station: RadioStationElement) -> Bool {
        favouriteRadioStations.contains(station)
    }

    func add(_ station: RadioStationElement) {
        favouriteRadioStations.insert(station)
        objectWillChange.send()
        print("Added 1 station to favourites: \(favouriteRadioStations.count)")
        save()
    }

    func remove(_ station: RadioStationElement) {

        favouriteRadioStations.remove(station)
        objectWillChange.send()
        print("Removed 1 station from favourites: \(favouriteRadioStations.count)")
        save()
    }
    

    func getFavorites() -> [RadioStationElement] {
        return Array(favouriteRadioStations)
    }

    private func save() {
        let savedArray = Array(favouriteRadioStations)
        if let encodedData = try? JSONEncoder().encode(savedArray) {
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }
    }

    private func load() {
        guard let savedData = UserDefaults.standard.data(forKey: saveKey),
              let decodedStations = try? JSONDecoder().decode([RadioStationElement].self, from: savedData) else { return }
        favouriteRadioStations = Set(decodedStations)
    }
}
