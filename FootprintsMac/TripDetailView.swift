//
//  TripDetailView.swift
//  FootprintsMac
//
//  Created by Jill Allan on 20/05/2024.
//

import MapKit
import SwiftUI

struct TripDetailView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var trip: Trip
    @State private var isEditViewPresented: Bool = false

    var body: some View {
        Map()
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Edit") {
                        isEditViewPresented.toggle()
                    }
                }
            }
            .sheet(isPresented: $isEditViewPresented) {
                TripEditorView(trip: trip)
            }

            .navigationTitle(trip.title)
    }
}

#Preview("Standard") {
    DataPreview {
        NavigationStack {
            TripDetailView(trip: .bedminsterToBeijing)
        }
        .frame(minWidth: 750, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
    } modelContainer: {
        SampleModelContainer.sample()
    }
}

#Preview("Editing title") {
    DataPreview {
        NavigationStack {
            TripDetailView(trip: .bedminsterToBeijing)
        }
        .frame(minWidth: 750, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
    } modelContainer: {
        SampleModelContainer.sample()
    }
}
