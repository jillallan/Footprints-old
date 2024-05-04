//
//  SampleModelContainer.swift
//  Footprints
//
//  Created by Jill Allan on 16/04/2024.
//

import Foundation
import SwiftData

/// A Model Container used for generating previews and sample data for development
struct SampleModelContainer {

    /// A singleton sample Model Container
    @MainActor
    static var sample: () -> ModelContainer = {
        do {
            let schema = Schema([Trip.self])
            let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: schema, configurations: [configuration])

            Task { @MainActor in
                await SampleDataGenerator.generateSampleData(modelContext: container.mainContext)
            }

            return container
        } catch {
            fatalError("Error loading SampleContainer")
        }
    }
}
