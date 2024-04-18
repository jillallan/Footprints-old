//
//  SampleData.swift
//  Footprints
//
//  Created by Jill Allan on 16/04/2024.
//

import Foundation
import SwiftData
import SwiftUI

/// A helper function to generate the sample data
///
/// The data is defined on an extension for each model
struct SampleDataGenerator {

    /// A helper function to generate the sample data
    /// - Parameter modelContext: The model context to use to generate the data
    @MainActor static func generateSampleData(modelContext: ModelContext) async {
        modelContext.insert(Trip.bedminsterToBeijing)
        modelContext.insert(Trip.mountains)
        modelContext.insert(Trip.anglesey)
        modelContext.insert(Trip.france)
        modelContext.insert(Trip.greece)
        modelContext.insert(Trip.london)
        modelContext.insert(Trip.spain)

//        modelContext.insert(Step.stJohnsLane)
//        modelContext.insert(Step.bedminsterStation)
//        
//        Step.stJohnsLane.trip = Trip.bedminsterToBeijing
//        Step.bedminsterStation.trip = Trip.bedminsterToBeijing
    }

    
    /// A random image to display in trip view
    static var randomTripImage: ImageResource {
        let images: [ImageResource] = [.china, .everest, .tibet]
        let randomInt = Int.random(in: 0...2)
        return images[randomInt]
    }
}
