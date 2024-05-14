//
//  AddTripView.swift
//  Footprints
//
//  Created by Jill Allan on 04/05/2024.
//

import SwiftUI

struct AddTripView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var navigationController: NavigationController

    // MARK: - Data Properties
    @Bindable var trip = Trip(title: "")

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
            EditTripFormHost(trip: trip)
                .navigationTitle("Add Trip")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            modelContext.insert(trip)
                            navigationController.navigationPath.append(trip)
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

#Preview("iOS") {
    DataPreview {
        NavigationStack {
            AddTripView()
        }
    } modelContainer: {
        SampleModelContainer.sample()
    }
}

#Preview("macOS") {
    DataPreview {
        NavigationStack {
            AddTripView()
        }
        .frame(width: 900, height: 600)
    } modelContainer: {
        SampleModelContainer.sample()
    }
}
