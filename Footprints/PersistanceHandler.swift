//
//  PersistanceHandler.swift
//  Footprints
//
//  Created by Jill Allan on 04/05/2024.
//

import Foundation
import SwiftData

struct PersistanceHandler {
    static func addTrip(
        modelContext: ModelContext,
        title: String,
        startDate: Date,
        endDate: Date,
        isAutoTrackingEnabled: Bool
    ) -> Trip {

        let newTrip = Trip(
            title: title,
            startDate: startDate,
            endDate: endDate,
            isAutoTrackingOn: isAutoTrackingEnabled
        )
        modelContext.insert(newTrip)

        startLocationServicesIfTripIsActive()

        return newTrip
    }

    static func startLocationServicesIfTripIsActive() {

    }
}
