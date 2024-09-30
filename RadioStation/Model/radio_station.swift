//
//  radio_station.swift
//  RadioStation
//
//  Created by Pantos, Thomas on 28/9/24.
//


import Foundation

struct RadioStationElement: Identifiable, Codable, Hashable {
    let stationID, title, description: String
    let logo: String
    let streamingURL: String
    let status, updated, ordering: String
    var isLiked: Bool = false
    var id: String { stationID }

    enum CodingKeys: String, CodingKey {
        case stationID = "station_id"
        case title, description, logo
        case streamingURL = "streaming_url"
        case status, updated, ordering
    }
}

typealias RadioStation = [RadioStationElement]


