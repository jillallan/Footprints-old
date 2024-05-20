//
//  TripDetailView.swift
//  FootprintsMac
//
//  Created by Jill Allan on 20/05/2024.
//

import SwiftUI

struct TripDetailView: View {
    @Bindable var trip: Trip
    var body: some View {
        Text("Hello, World!")
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
            TripDetailView(trip: .bedminsterToBeijing)
        }
    } modelContainer: {
        SampleModelContainer.sample()
    }
}
