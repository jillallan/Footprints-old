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

            // MARK: - Debug

#if DEBUG
            .toolbar {
                ToolbarItem {
                    Button("Samples") {
                        Task {
                            await createData()
                        }
                    }
                }
            }
#endif
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
