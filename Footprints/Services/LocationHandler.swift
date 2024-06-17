//
//  LocationsHandler.swift
//  Footprints
//
//  Created by Jill Allan on 14/06/2024.
//

import CoreLocation
import Foundation
import OSLog

@Observable
final class LocationHandler: Sendable {
    var location: CLLocation?
    var isStationary: Bool?

    var locationManager = CLLocationManager()

    func requestUserAuthorization() async throws {        
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func startCurrentLocationUpdates() async throws {
        for try await locationUpdate in CLLocationUpdate.liveUpdates() {
            guard let location = locationUpdate.location else { return }

            self.location = location
        }
    }

    func getCurrentLocation() async throws {
        for try await locationUpdate in CLLocationUpdate.liveUpdates() {
            guard let location = locationUpdate.location else { return }

            self.location = location
            break
        }
    }
}

extension LocationHandler {
    @MainActor
    static var preview: LocationHandler = {
        LocationHandler()
    }()
}
