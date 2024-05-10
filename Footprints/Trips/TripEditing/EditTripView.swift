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
    var modelContext: ModelContext

    // MARK: - Computed Properties
    var saveDisabled: Bool {
        if trip.title == "" {
            true
        } else {
            false
        }
    }

    init(tripID: PersistentIdentifier, in container: ModelContainer) {
        modelContext = ModelContext(container)
        modelContext.autosaveEnabled = false
        trip = modelContext.model(for: tripID) as? Trip ?? Trip()
    }

    var body: some View {
        NavigationStack {
//            EditTripFormHost(trip: trip)
            TextField("Title", text: $trip.title)

            // MARK: - Navigation
            .navigationTitle("Add Trip")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        try? modelContext.save()
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
