//
//  ModelContainerTestCase.swift
//  FootprintsTests
//
//  Created by Jill Allan on 16/04/2024.
//

import SwiftData
import XCTest
@testable import Footprints

class ModelContainerTestCase: XCTestCase {
    var container: MockModelContainer!
    var modelContext: ModelContext!

    @MainActor override func setUpWithError() throws {
        container = MockModelContainer(inMemory: true)
        modelContext = container.container.mainContext
    }

    @MainActor override func tearDownWithError() throws {
        try modelContext.delete(model: Trip.self)
//        try modelContext.delete(model: Step.self)
//        try modelContext.delete(model: Location.self)
    }
}
