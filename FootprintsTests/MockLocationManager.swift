//
//  MockLocationManager.swift
//  FootprintsTests
//
//  Created by Jill Allan on 15/06/2024.
//

import CoreLocation
import Foundation
@testable import Footprints

final class MockLocationManager: CLLocationManager {
    var authorizationStatusStub: CLAuthorizationStatus = .notDetermined
    var requestWhenInUseAuthorizationCalled = false

    override var authorizationStatus: CLAuthorizationStatus {
        return authorizationStatusStub
    }

    override func requestWhenInUseAuthorization() {
        requestWhenInUseAuthorizationCalled = true
    }
}
