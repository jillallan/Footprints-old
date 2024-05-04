//
//  TripView.swift
//  Footprints
//
//  Created by Jill Allan on 15/04/2024.
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
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    @Environment(\.sizeCategory) private var sizeCategory
    @Query(sort: \Trip.startDate) private var trips: [Trip]

    @State private var size: CGSize = .zero

    var gridSpacing: Double {
        if prefersTabNavigation {
            20.0
        } else {
            30.0
        }
    }

    var columns: [GridItem] {
        if sizeCategory.isAccessibilityCategory {
            [GridItem(.adaptive(minimum: 300, maximum: 450), spacing: gridSpacing)]
        } else {
            [GridItem(.adaptive(minimum: 240, maximum: 380), spacing: gridSpacing)]
        }
    }

    /// Sets the padding to restict the width of the lazy grid view
    /// Minimum padding of 50 on split view navigation
    /// Set padding of 30 on tab view navigation
    var padding: Double {
        if !prefersTabNavigation {
            let minimumPadding = 40.0
            if size.width > 900 {
                let padding = (size.width - 900) / 2
                return padding < minimumPadding ? minimumPadding : padding
            } else {
                return minimumPadding
            }
        } else {
            return 20.0
        }
    }

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
            #if !os(macOS)
            .toolbarBackground(.hidden, for: .navigationBar)
            #endif
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add Trip", systemImage: "plus") {

                    }
                }
            }
            .getSize($size)
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

#Preview("iphone") {
    TripView()
        .modelContainer(SampleModelContainer.sample())
}

#Preview("ipad") {
    NavigationSplitView {
        List {
            Text("Trips")
        }
    } detail: {
        TripView()
            .modelContainer(SampleModelContainer.sample())
    }
}

#Preview("macOS") {
    NavigationSplitView {
        List {
            Text("Trips")
        }
    } detail: {
        TripView()
            .modelContainer(SampleModelContainer.sample())
    }
    .frame(width: 900, height: 600)
}
