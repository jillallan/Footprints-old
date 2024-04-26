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
#if DEBUG
    @Environment(\.modelContext) private var modelContext
#endif
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.sizeCategory) private var sizeCategory
    @Query(sort: \Trip.startDate) private var trips: [Trip]

    let columnsCompact = [GridItem(spacing: 10.0)]
    let columnsRegular = Array(repeating: GridItem(spacing: 10.0), count: 3)
    var columns: [GridItem] {

        if horizontalSizeClass == .regular {
            return columnsRegular
        } else {
            return columnsCompact
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .center, spacing: 10.0) {
                    ForEach(trips) { trip in
                        TripCard(trip: trip)
                    }
                }
            }
            .navigationTitle("Trips")
#if DEBUG
            .onAppear {
                Task {
                    // swiftlint:disable:next force_try
                    try! modelContext.delete(model: Trip.self)
                    await createData()
                }
            }
#endif
            // MARK: - Debug
        }
    }
#if DEBUG
    @MainActor
    func createData() async {
        await SampleDataGenerator.generateSampleData(modelContext: modelContext)
    }
#endif
}

#Preview {
    TripView()
        .modelContainer(SampleModelContainer.sample())
}
