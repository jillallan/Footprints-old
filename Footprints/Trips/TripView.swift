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
    @Query(sort: \Trip.startDate) private var trips: [Trip]

    let columns = [GridItem(.adaptive(minimum: 200, maximum: 400), spacing: 10.0, alignment: .center)]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .center, spacing: 10.0) {
                    ForEach(trips) { trip in
                        TripCard(trip: trip)
                    }
                }
            }
            .padding()
            .navigationTitle("Trips")
        }
    }
}

#Preview {
    TripView()
        .modelContainer(SampleModelContainer.sample())
}
