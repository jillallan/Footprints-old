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
            .scaledToFit()
            
            .overlay {
                VStack {}
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.35)],
                        startPoint: .center,
                        endPoint: .bottom
                    )
                )
            }
            .overlay {
                VStack {
                    Spacer()
                    Text(trip.title)
                        .font(.headline)
                    Text(trip.startDate, style: .date)
                        .font(.subheadline)
                }
                .foregroundStyle(Color.white)
                .padding()
            }
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .circular))
    }
}

#Preview {
    DataPreview {
        TripCard(trip: .bedminsterToBeijing)
    } modelContainer: {
        SampleModelContainer.sample()
    }
}
