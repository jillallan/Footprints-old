//
//  TripDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 06/05/2024.
//

import MapKit
import SwiftUI

struct TripDetailView: View {
    @Bindable var trip: Trip
    @State var isTripTitleBeingEditied: Bool = false

    var body: some View {

        Map()
            .safeAreaInset(edge: .bottom) {
                ScrollView(.horizontal) {
                    LazyVGrid(
                        columns: [GridItem(.flexible(minimum: 100, maximum: 300), spacing: 10.0)],
                        spacing: 10.0
                    ) {
                        Image(SampleDataGenerator.randomTripImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .circular))
                            .iOS { $0.aspectRatio(1.5, contentMode: .fill) }
                            .macOS { $0.aspectRatio(1.0, contentMode: .fill) }
                            .watchOS { $0.aspectRatio(1.9, contentMode: .fill) }
                            .containerRelativeFrame(.horizontal)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Edit") {
                        //
                    }
                }
            }
            .popover(isPresented: $isTripTitleBeingEditied) {

            }

            .navigationTitle(trip.title)
#if os(iOS)
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbar(.hidden, for: .tabBar)
#endif
    }
}

#Preview("Standard") {
    DataPreview {
        NavigationStack {
            TripDetailView(trip: .bedminsterToBeijing)
        }
    } modelContainer: {
        SampleModelContainer.sample()
    }
}

#Preview("Editing title") {
    DataPreview {
        NavigationStack {
            TripDetailView(trip: .bedminsterToBeijing, isTripTitleBeingEditied: true)
        }
    } modelContainer: {
        SampleModelContainer.sample()
    }
}
