//
//  SampleData.swift
//  Footprints
//
//  Created by Jill Allan on 16/04/2024.
//

import Foundation
import SwiftData

struct SampleDataGenerator {
    @MainActor static func generateSampleData(modelContext: ModelContext) async {
        modelContext.insert(Trip.bedminsterToBeijing)
        modelContext.insert(Trip.mountains)
        
//        modelContext.insert(Step.stJohnsLane)
//        modelContext.insert(Step.bedminsterStation)
//        
//        Step.stJohnsLane.trip = Trip.bedminsterToBeijing
//        Step.bedminsterStation.trip = Trip.bedminsterToBeijing
    }
}
