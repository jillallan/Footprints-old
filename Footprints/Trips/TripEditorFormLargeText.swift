//
//  EditTripFormLargeText.swift
//  Footprints
//
//  Created by Jill Allan on 06/05/2024.
//

import SwiftUI

struct TripEditorFormLargeText: View {
    @Bindable var trip: Trip
    @Binding var isAutoTrackingToggleDisabled: Bool

    var body: some View {
        Section {
            TextField("Name your trip", text: $trip.title, prompt: Text("Name your trip"))
        } header: {
            Text("Trip Title")
        }

        Section {
            DatePicker("", selection: $trip.startDate, displayedComponents: [.date])
        } header: {
            Text("Start Date")
        }

        Section {
            DatePicker("", selection: $trip.endDate, displayedComponents: [.date])
        } header: {
            Text("End Date")
        }

        Section {
            Toggle("", isOn: $trip.isAutoTrackingOn)
                .disabled(isAutoTrackingToggleDisabled)
        } header: {
            Text("Enable automatic trip tracking")
//                } footer: {
//                    if locationHandler.locationUpdatesAuthorized == 1 {
            // swiftlint:disable:next line_length
//                        Text("Auto tracking is disabled as location services have been turned off for this app.  Go to iPhone settings to enable")
//                    }
        }
    }
}

#Preview {
    DataPreview {
        NavigationStack {
            TripEditorForm(trip: .bedminsterToBeijing, isAutoTrackingToggleDisabled: .constant(false))
        }
    } modelContainer: {
        SampleModelContainer.sample()
    }
}
