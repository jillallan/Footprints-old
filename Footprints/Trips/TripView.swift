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
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    @Environment(\.sizeCategory) private var sizeCategory
    @Query(sort: \Trip.startDate) private var trips: [Trip]

    @State private var width: CGFloat = .zero

    var columnsCount: Int {
        if width > 768 {
            return 3
        } else if width > 480 {
            return 2
        } else {
            return 1
        }
    }

    var columns: [GridItem] {
        Array(repeating: GridItem(spacing: 10.0), count: columnsCount)
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(
                        columns: columns,
                        alignment: .center,
                        spacing: 10.0
                    ) {
                        ForEach(trips) { trip in
                            TripCard(trip: trip)
                        }
                    }
                    .if(prefersTabNavigation) { view in
                        view.padding()
                    }
                    .if(!prefersTabNavigation) { view in
                        view
                            .padding(
                                .horizontal,
                                width > 600 ? geometry.size.width * 0.2 : 20
                            )
                    }
                    .onAppear {
                        width = geometry.size.width
                    }
                    .onChange(of: geometry.size.width) {
                        width = geometry.size.width
                    }
                }
            }
            .navigationTitle("Trips")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add Trip", systemImage: "plus") {
                        // TODO:
                    }
                }
            }
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
