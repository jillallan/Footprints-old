//
//  AddTripView.swift
//  Footprints
//
//  Created by Jill Allan on 04/05/2024.
//

import SwiftUI

struct AddTripView: View {
    @Environment(\.sizeCategory) private var sizeCategory
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    // MARK: - Data Properties
    @State var title: String = ""
    @State var startDate: Date = Date.now
    @State var endDate: Date = Date.now
    @State var isAutoTrackingEnabled: Bool = false

    // MARK: - View Properties
    @State var isAutoTrackingToggleDisabled: Bool = false
    @State private var locationServicesDisabled: Bool = false

    // MARK: - Computed Properties
    var saveDisabled: Bool {
        if title == "" {
            true
        } else {
            false
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                if sizeCategory.isAccessibilityCategory {
                    AddTripFormLargeText(
                        title: $title,
                        startDate: $startDate,
                        endDate: $endDate,
                        isTripAutoTrackingEnabled: $isAutoTrackingEnabled,
                        isAutoTrackingToggleDisabled: $isAutoTrackingToggleDisabled
                    )
                } else {
                    AddTripForm(
                        title: $title,
                        startDate: $startDate,
                        endDate: $endDate,
                        isTripAutoTrackingEnabled: $isAutoTrackingEnabled,
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
            .navigationTitle("Add Trip")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let trip = PersistanceHandler.addTrip(
                            modelContext: modelContext,
                            title: title,
                            startDate: startDate,
                            endDate: endDate,
                            isAutoTrackingEnabled: isAutoTrackingEnabled
                        )
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

        // MARK: - View updates
        .onChange(of: startDate) {
            if endDate < startDate {
                endDate = startDate
            }
        }
        .onChange(of: endDate) {
            if startDate > endDate {
                startDate = endDate
            }
        }
        .onChange(of: isAutoTrackingEnabled) { _, isEnabled in
            if isEnabled {

            }
        }
    }
}

struct AddTripForm: View {
    @Binding var title: String
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var isTripAutoTrackingEnabled: Bool
    @Binding var isAutoTrackingToggleDisabled: Bool

    var body: some View {
        Section {
            TextField("Name your trip", text: $title, prompt: Text("Name your trip"))
        }

        Section {
            DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
            DatePicker("End Date", selection: $endDate, displayedComponents: [.date])
        }

        Section {
            Toggle("Enable automatic trip tracking", isOn: $isTripAutoTrackingEnabled)
                .disabled(isAutoTrackingToggleDisabled)
        } footer: {
            //                if locationHandler.locationUpdatesAuthorized == 1 {
            //                    Text("Auto tracking is disabled as location services have been turned off for this app.  Go to iPhone settings to enable")
            //                }
        }
    }
}

struct AddTripFormLargeText: View {
    @Binding var title: String
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var isTripAutoTrackingEnabled: Bool
    @Binding var isAutoTrackingToggleDisabled: Bool

    var body: some View {
        Section {
            TextField("Name your trip", text: $title, prompt: Text("Name your trip"))
        } header: {
            Text("Trip Title")
        }

        Section {
            DatePicker("", selection: $startDate, displayedComponents: [.date])
        } header: {
            Text("Start Date")
        }

        Section {
            DatePicker("", selection: $endDate, displayedComponents: [.date])
        } header: {
            Text("End Date")
        }

        Section {
            Toggle("", isOn: $isTripAutoTrackingEnabled)
                .disabled(isAutoTrackingToggleDisabled)
        } header: {
            Text("Enable automatic trip tracking")
//                } footer: {
//                    if locationHandler.locationUpdatesAuthorized == 1 {
//                        Text("Auto tracking is disabled as location services have been turned off for this app.  Go to iPhone settings to enable")
//                    }
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
