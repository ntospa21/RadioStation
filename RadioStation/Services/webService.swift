//
//  webService.swift
//  RadioStation
//
//  Created by Pantos, Thomas on 30/9/24.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}


class WebService {
    func downloadData<T: Codable>(fromURL: String) async -> T? {
        do {
            guard let url = URL(string: fromURL) else { throw NetworkError.badUrl }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus }
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw NetworkError.failedToDecodeResponse }
            
            return decodedResponse
        } catch NetworkError.badUrl {
            print("There was an error creating the URL")
        } catch NetworkError.badResponse {
            print("Did not get a valid response")
        } catch NetworkError.badStatus {
            print("Did not get a 2xx status code from the response")
        } catch NetworkError.failedToDecodeResponse {
            print("Failed to decode response into the given type")
        } catch {
            print("An error occured downloading the data")
        }
        
        return nil
    }
    
    func saveRadioStationsLocally(stations: RadioStation, fileName: String = "radio_stations.json") {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(stations)
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            
            let fileURL = documentsDirectory?.appendingPathComponent(fileName)
            
            try data.write(to: fileURL!)
            print("Radio stations saved successfully at: \(fileURL!)")
        } catch {
            print("Failed to save radio stations: \(error.localizedDescription)")
        }
    }
    
    func loadRadioStationsLocally(fileName: String = "radio_stations.json") -> RadioStation? {
        let decoder = JSONDecoder()
        do {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            
            let fileURL = documentsDirectory?.appendingPathComponent(fileName)
            
            let data = try Data(contentsOf: fileURL!)
            
            let stations = try decoder.decode(RadioStation.self, from: data)
            return stations
        } catch {
            print("Failed to load radio stations: \(error.localizedDescription)")
            return nil
        }
    }
    
}
