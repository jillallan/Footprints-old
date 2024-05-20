//
//  EditTripForm.swift
//  Footprints
//
//  Created by Jill Allan on 06/05/2024.
//

import SwiftUI

struct EditTripForm: View {
    @Bindable var trip: Trip
    @Binding var isAutoTrackingToggleDisabled: Bool

    var body: some View {
        Section {
            TextField("Name your trip", text: $trip.title, prompt: Text("Name your trip"))
        }

        Section {
            DatePicker("Start Date", selection: $trip.startDate, displayedComponents: [.date])
            DatePicker("End Date", selection: $trip.endDate, displayedComponents: [.date])
        }

        Section {
            Toggle("Enable automatic trip tracking", isOn: $trip.isAutoTrackingOn)
                .disabled(isAutoTrackingToggleDisabled)
        } footer: {
            //                if locationHandler.locationUpdatesAuthorized == 1 {
            //                    Text("Auto tracking is disabled as location services have been turned off for this app.  Go to iPhone settings to enable")
            //                }
        }
    }
}

#Preview {
    DataPreview {
        NavigationStack {
            EditTripForm(trip: .bedminsterToBeijing, isAutoTrackingToggleDisabled: .constant(false))
        }
    } modelContainer: {
        SampleModelContainer.sample()
    }
}
