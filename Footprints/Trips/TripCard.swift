//
//  TripCard.swift
//  Footprints
//
//  Created by Jill Allan on 16/04/2024.
//

import SwiftUI

struct TripCard: View {
    @Bindable var trip: Trip

    var body: some View {
        Image(SampleDataGenerator.randomTripImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .overlay {
                TextOverlay(trip: trip)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .circular))
            .iOS { $0.aspectRatio(1.5, contentMode: .fill) }
            .macOS { $0.aspectRatio(1.0, contentMode: .fill) }
            .watchOS { $0.aspectRatio(1.9, contentMode: .fill) }
    }
}

struct TextOverlay: View {
    @Bindable var trip: Trip

    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.6), .black.opacity(0.0)]),
            startPoint: .bottom,
            endPoint: .center
        )
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                Text(trip.title)
                    .font(.title)
                    .bold()
                Text(trip.startDate, style: .date)
            }
            .padding()
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    DataPreview {
        LazyVStack {
            TripCard(trip: .bedminsterToBeijing)
        }
    } modelContainer: {
        SampleModelContainer.sample()
    }
}
