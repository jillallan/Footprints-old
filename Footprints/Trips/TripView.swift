//
//  TripView.swift
//  Footprints
//
//  Created by Jill Allan on 05/05/2024.
//

import OSLog
import SwiftData
import SwiftUI

struct TripView: View {
#if swift(>=6.0)
    #warning("Reevaluate whether this decoration is necessary.")
#endif
    // MARK: - Debugging
    nonisolated(unsafe) static let logger = Logger(category: String(describing: TripView.self))
#if DEBUG
    @Environment(\.modelContext) private var modelContext
#endif
    @EnvironmentObject var navigationController: NavigationController
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    @Environment(\.sizeCategory) private var sizeCategory

    @State private var size: CGSize = .zero
    @State var isAddTripViewPresented: Bool = false
    @Query(sort: \Trip.startDate, order: .reverse) private var trips: [Trip]
//    @State private var newTripID: PersistentIdentifier?

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

    // Sets the padding to restict the width of the lazy grid view
    // If you set the size on the lazy grid view itself
    // it puts the scroll inidcators in the wrong place
    // Can be fixed with contentMargins but not on mac

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
        NavigationStack(path: $navigationController.navigationPath) {
            ScrollView {
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: gridSpacing
                ) {
                    ForEach(trips) { trip in
                        NavigationLink(value: trip) {
                            if sizeCategory.isAccessibilityCategory {
                                TripCardLargeText(trip: trip)
                            } else {
                                TripCard(trip: trip)
                            }
                        }
                    }
                }
                .padding(.horizontal, padding)
            }
            // MARK: - Navigation
            .navigationTitle("Trips")
            .navigationDestination(for: Trip.self) { trip in
                TripDetailView(trip: trip)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add Trip", systemImage: "plus") {
                        isAddTripViewPresented.toggle()
                    }
                }
            }
            .sheet(isPresented: $isAddTripViewPresented) {
                AddTripView()
            }
#if !os(macOS)
            .toolbarBackground(.hidden, for: .navigationBar)
#endif
            // MARK: - View updates
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
//        try! modelContext.delete(model: Trip.self)
        await SampleDataGenerator.generateSampleData(modelContext: modelContext)
    }
#endif
}

#Preview {
    TripView()
        .modelContainer(SampleModelContainer.sample())
        .environmentObject(NavigationController.preview)
}
