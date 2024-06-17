//
//  TripMap.swift
//  Footprints
//
//  Created by Jill Allan on 14/06/2024.
//

import MapKit
import SwiftUI

struct TripMap: View {
    @Bindable var trip: Trip

    var body: some View {
        Map {
            ForEach(trip.steps) { step in
                Marker("", systemImage: "car", coordinate: step.coordinate)
            }
        }
    }
}

#Preview {
    DataPreview {
        TripMap(trip: .bedminsterToBeijing)
    } modelContainer: {
        SampleModelContainer.sample()
    }
}
