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
        VStack {
            Image(SampleDataGenerator.randomTripImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        .overlay {
            VStack {}
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.45)],
                        startPoint: .center,
                        endPoint: .bottomLeading
                    )
                )
        }
        .overlay {
            HStack {
                VStack {
                    Spacer()
                    Text(trip.title)
                        .font(.headline)
                    Text(trip.startDate, style: .date)
                        .font(.subheadline)
                }
                .foregroundStyle(Color.white)
                .padding()
                Spacer()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .circular))
        .aspectRatio(1.0, contentMode: .fill)
    }
}

#Preview {
    DataPreview {
        TripCard(trip: .bedminsterToBeijing)
    } modelContainer: {
        SampleModelContainer.sample()
    }
}
