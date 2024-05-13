//
//  EditTripView.swift
//  Footprints
//
//  Created by Jill Allan on 06/05/2024.
//

import SwiftData
import SwiftUI

struct EditTripView: View {
    @Environment(\.dismiss) private var dismiss

    // MARK: - Data Properties
    @Bindable var trip: Trip
    @State var editedTrip: Trip?

    // MARK: - Computed Properties
    var saveDisabled: Bool {
        if trip.title == "" {
            true
        } else {
            false
        }
    }

    var body: some View {
        NavigationStack {
            EditTripFormHost(trip: editedTrip ?? trip)

            // MARK: - Navigation
            .navigationTitle("Add Trip")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let editedTrip {
                            trip.title = editedTrip.title
                            trip.startDate = editedTrip.startDate
                            trip.endDate = editedTrip.endDate
                            trip.isAutoTrackingOn = editedTrip.isAutoTrackingOn
                        }
                        dismiss()
                    }
                    .disabled(saveDisabled)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                editedTrip = Trip(trip: trip)
            }
        }
    }
}

//#Preview("iOS") {
//    let container = SampleModelContainer.sample()
//    let context = ModelContext(container)
//    let trip = Trip()
//
//    return NavigationStack {
//        EditTripView(
//            tripID: trip.id,
//            in: container
//        )
//    }
//}
