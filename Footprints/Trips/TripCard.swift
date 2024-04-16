//
//  TripCard.swift
//  Footprints
//
//  Created by Jill Allan on 16/04/2024.
//

import SwiftUI

struct TripCard: View {
    var body: some View {
        Image(SampleDataGenerator.randomTripImage)
            .resizable()
            .scaledToFit()
            .overlay {
                Text("Placeholder")
                    .font(.title)
                    .foregroundStyle(Color.white)
            }
    }
}

#Preview {
    TripCard()
}
