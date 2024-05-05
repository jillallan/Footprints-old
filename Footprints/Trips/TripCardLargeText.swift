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
                .shadow(radius: 7)
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
