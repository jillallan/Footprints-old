//
//  TripView.swift
//  Footprints Watch App
//
//  Created by Jill Allan on 04/05/2024.
//

import OSLog
import SwiftData
import SwiftUI

/// A list of trips
struct TripView: View {
#if swift(>=6.0)
    #warning("Reevaluate whether this decoration is necessary.")
#endif
    // MARK: - Debugging
    nonisolated(unsafe) static let logger = Logger(category: String(describing: TripView.self))

#if DEBUG
    @Environment(\.modelContext) private var modelContext
#endif
    @Environment(\.sizeCategory) private var sizeCategory

    @Query(sort: \Trip.startDate, order: .reverse) private var trips: [Trip]

    var gridSpacing: Double = 10.0
    let columns: [GridItem] = [GridItem(.flexible(minimum: 135, maximum: 160))]
    let padding: Double = 0.0

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: gridSpacing
                ) {
                    ForEach(trips) { trip in
                        if sizeCategory.isAccessibilityCategory {
                            TripCardLargeText(trip: trip)
                        } else {
                            TripCard(trip: trip)
                        }
                    }
                }
                .padding(.horizontal, padding)
            }
            // MARK: - Navigation
            .navigationTitle("Trips")
            .toolbarBackground(.hidden, for: .navigationBar)

#if DEBUG
            .onAppear {
                Task {
                    await createData()
                }
            }

#endif
        }
    }

#if DEBUG
    @MainActor
    func createData() async {
        // swiftlint:disable:next force_try
        try! modelContext.delete(model: Trip.self)
        await SampleDataGenerator.generateSampleData(modelContext: modelContext)
    }
#endif
}

#Preview("watch") {
    TripView()
        .modelContainer(SampleModelContainer.sample())
}
