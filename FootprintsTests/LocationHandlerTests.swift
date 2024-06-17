//
//  LocationHandlerTests.swift
//  FootprintsTests
//
//  Created by Jill Allan on 15/06/2024.
//

import CoreLocation
import XCTest
@testable import Footprints

final class LocationHandlerTests: XCTestCase {

    var locationHandler: LocationHandler!
    var mockLocationManager: MockLocationManager!

    override func setUp() {
        super.setUp()
        mockLocationManager = MockLocationManager()
        locationHandler = LocationHandler()
        locationHandler.locationManager = mockLocationManager
    }

    override func tearDown() {
        locationHandler = nil
        mockLocationManager = nil
        super.tearDown()
    }

    func testRequestUserAuthorization_notDetermined() async throws {
        print("Testing location handler")
        mockLocationManager.authorizationStatusStub = .notDetermined
        try await locationHandler.requestUserAuthorization()
        XCTAssertTrue(mockLocationManager.requestWhenInUseAuthorizationCalled)
    }

    func testRequestUserAuthorization_authorized() async throws {
        mockLocationManager.authorizationStatusStub = .authorizedWhenInUse
        try await locationHandler.requestUserAuthorization()
        XCTAssertFalse(mockLocationManager.requestWhenInUseAuthorizationCalled)
    }

    func testStartCurrentLocationUpdates() async throws {
        let expectedLocation = CLLocation(latitude: 37.7749, longitude: -122.4194)

        mockLocationManager.authorizationStatusStub = .authorizedWhenInUse
        print("test 1")
        try await locationHandler.startCurrentLocationUpdates()
        print("test 2")
        XCTAssertEqual(locationHandler.location, expectedLocation)
    }
}
