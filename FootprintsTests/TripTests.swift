//
//  TripTests.swift
//  FootprintsTests
//
//  Created by Jill Allan on 16/04/2024.
//

import XCTest
@testable import Footprints

final class TripTests: ModelContainerTestCase {
    var dateFormatter: DateFormatter!

    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()

        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }

    func testTrip_initialiseTripFromTrip_createsMatchingTrip() {
        
    }

    func testTrip_equatbleConformance_canCompareTwoTripsForEquailty() {

    }
}
