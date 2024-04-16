//
//  TripView.swift
//  Footprints
//
//  Created by Jill Allan on 15/04/2024.
//

import SwiftData
import SwiftUI

/// A list of trips
struct TripView: View {
    @Query private var trips: [Trip]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(trips) { trip in
                        TripCard()
                    }
                }
            }
            .navigationTitle("Trips")
        }
    }
}

#Preview {
    TripView()
        .modelContainer(SampleModelContainer.sample())
}
