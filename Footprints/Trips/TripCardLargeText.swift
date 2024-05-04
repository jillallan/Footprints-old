//
//  TripCardLargeText.swift
//  Footprints
//
//  Created by Jill Allan on 04/05/2024.
//

import SwiftUI

struct TripCardLargeText: View {
    @Bindable var trip: Trip

    var body: some View {
        VStack {
            Image(SampleDataGenerator.randomTripImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .circular))
//                .iOS { $0.aspectRatio(1.5, contentMode: .fill) }
//                .macOS { $0.aspectRatio(1.0, contentMode: .fill) }
//                .watchOS { $0.aspectRatio(1.9, contentMode: .fill) }
            TextOverlayLargeText(trip: trip)

        }
    }
}

struct TextOverlayLargeText: View {
    @Bindable var trip: Trip

    var body: some View {
        VStack(alignment: .leading) {
            Text(trip.title)
                .font(.title)
                .bold()
            Text(trip.startDate, style: .date)
        }
        .padding()
    }
}

#Preview {
    DataPreview {
        LazyVStack {
            TripCardLargeText(trip: .bedminsterToBeijing)
        }
    } modelContainer: {
        SampleModelContainer.sample()
    }
}
