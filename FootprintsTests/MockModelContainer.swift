//
//  MockModelContainer.swift
//  FootprintsTests
//
//  Created by Jill Allan on 16/04/2024.
//

import Foundation
import SwiftData
@testable import Footprints

/// A mock Model Container used for testing
struct MockModelContainer {
    let container: ModelContainer

    /// Initializes the mock model container
    /// - Parameter inMemory: If true the data will be in memory and destroyed when the container is destroyed
    init(inMemory: Bool) {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
            container = try ModelContainer(for: Trip.self, configurations: configuration)
        } catch {
            fatalError("Unable to load model container: \(error.localizedDescription)")
        }
    }
}
