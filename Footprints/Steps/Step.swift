//
//  Step.swift
//  Footprints
//
//  Created by Jill Allan on 20/05/2024.
//

import SwiftData
import SwiftUI

@Model
final class Step {
    var timestamp: Date
    var latitude: Double
    var longitude: Double
    var altitude: Double
    var trip: Trip?

    /// Required property for CustomDebugStringConvertible protocol
    var debugDescription: String {
        """
        Step on: \(timestamp.formatted(date: .abbreviated, time: .shortened)), \
        latitude: \(latitude), longitude: \(longitude), altitude: \(altitude))
        """
    }

    init(timestamp: Date = .now, latitude: Double, longitude: Double, altitude: Double) {
        self.timestamp = timestamp
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
    }

    convenience init(timestamp: Date = .now, latitude: Double, longitude: Double) {
        self.init(timestamp: timestamp, latitude: latitude, longitude: longitude, altitude: 0.0)
    }

    convenience init(timestamp: Date = .now) {
        self.init(timestamp: timestamp, latitude: 0.0, longitude: 0.0, altitude: 0.0)
    }
}
