//
//  TestSampleData.swift
//  FootprintsTests
//
//  Created by Jill Allan on 16/04/2024.
//

import XCTest
@testable import Footprints
import SwiftData

final class TestSampleData: ModelContainerTestCase {

    @MainActor
    func testSampleData_createsTwoTrips() async throws {
        await SampleDataGenerator.generateSampleData(modelContext: modelContext)
        let fetchDescriptor = FetchDescriptor<Trip>()

        let tripCount = try modelContext.fetchCount(fetchDescriptor)

        XCTAssertEqual(tripCount, 2)
    }
}
