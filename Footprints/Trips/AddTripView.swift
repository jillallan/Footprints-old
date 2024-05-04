//
//  AddTripView.swift
//  Footprints
//
//  Created by Jill Allan on 04/05/2024.
//

import SwiftUI

struct AddTripView: View {
    @Environment(\.sizeCategory) private var sizeCategory

    // MARK: - Data Properties
    @State var title: String = ""
    @State var startDate: Date = Date.now
    @State var endDate: Date = Date.now
    @State var isTripAutoTrackingEnabled: Bool = false

    // MARK: - View Properties
    @State var isAutoTrackingToggleDisabled: Bool = false
    @State private var locationServicesDisabled: Bool = false

    // MARK: - Navigation Properties
    @Environment(\.dismiss) private var dismiss

    // MARK: - Computed Properties
    var saveDisabled: Bool {
        if title == "" {
            true
        } else {
            false
        }
    }

    var body: some View {
        Form {
            if sizeCategory.isAccessibilityCategory {
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
            } else {
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

                }
                .disabled(saveDisabled)
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {

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
        .onChange(of: isTripAutoTrackingEnabled) { _, isEnabled in
            if isEnabled {

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
