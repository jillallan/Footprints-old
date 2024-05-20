//
//  EditTripDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 19/05/2024.
//

import SwiftUI

struct TripEditorView: View {
    @Environment(\.sizeCategory) private var sizeCategory
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var navigationController: NavigationController

    @Bindable var trip: Trip
    @State var tempTrip: Trip?

    @State var isAutoTrackingToggleDisabled: Bool = false
    @State private var locationServicesDisabled: Bool = false
    let isNew: Bool

    // MARK: - Computed Properties
    var saveDisabled: Bool {
        if trip.title == "" {
            true
        } else {
            false
        }
    }

    init(trip: Trip = Trip(title: ""), isNew: Bool = false) {
        self.isNew = isNew
        self.trip = trip
        if !isNew {
            tempTrip = trip
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                if sizeCategory.isAccessibilityCategory {
                    TripEditorFormLargeText(
                        trip: tempTrip ?? trip,
                        isAutoTrackingToggleDisabled: $isAutoTrackingToggleDisabled
                    )
                } else {
                    TripEditorForm(
                        trip: tempTrip ?? trip,
                        isAutoTrackingToggleDisabled: $isAutoTrackingToggleDisabled
                    )
                }
            }
            // MARK: - Configuration
            .formStyle(.grouped)
            .macOS { $0.frame(
                minWidth: 440, maxWidth: .infinity,
                minHeight: 220, maxHeight: .infinity) }

            // MARK: - Navigation
            .navigationTitle(isNew ? "Add Trip" : "Edit Trip")
#if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
#endif
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if isNew {
                            addTrip()
                        } else {
                            updateTrip()
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
            // MARK: - View updates
            .onChange(of: trip.startDate) {
                if trip.endDate < trip.startDate {
                    trip.endDate = trip.startDate
                }
            }
            .onChange(of: trip.endDate) {
                if trip.startDate > trip.endDate {
                    trip.startDate = trip.endDate
                }
            }
            //            .onChange(of: isAutoTrackingEnabled) { _, isEnabled in
            //                if isEnabled {
            //
            //                }
            //            }
        }
    }

    func addTrip() {
        modelContext.insert(trip)
        navigationController.navigationPath.append(trip)
    }

    func updateTrip() {
        if let tempTrip {
            trip.title = tempTrip.title
            trip.startDate = tempTrip.startDate
            trip.endDate = tempTrip.endDate
            trip.isAutoTrackingOn = tempTrip.isAutoTrackingOn
        }
    }
}

#Preview("iOS existing trip") {
    DataPreview {
        NavigationStack {
            TripEditorView(trip: .anglesey)
        }
    } modelContainer: {
        SampleModelContainer.sample()
    }
}

#Preview("iOS new trip") {
    DataPreview {
        NavigationStack {
            TripEditorView(isNew: true)

        }
    } modelContainer: {
        SampleModelContainer.sample()
    }
}
