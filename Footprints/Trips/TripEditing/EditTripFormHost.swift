//
//  EditTripViewHost.swift
//  Footprints
//
//  Created by Jill Allan on 07/05/2024.
//

import SwiftUI

struct EditTripFormHost: View {
    @Environment(\.sizeCategory) private var sizeCategory
    @Bindable var trip: Trip

    // MARK: - View Properties
    @State var isAutoTrackingToggleDisabled: Bool = false
    @State private var locationServicesDisabled: Bool = false

    var body: some View {
        Form {
            if sizeCategory.isAccessibilityCategory {
                EditTripFormLargeText(
                    trip: trip,
                    isAutoTrackingToggleDisabled: $isAutoTrackingToggleDisabled
                )
            } else {
                EditTripForm(
                    trip: trip,
                    isAutoTrackingToggleDisabled: $isAutoTrackingToggleDisabled
                )
            }
        }

        // MARK: - Configuration
        .formStyle(.grouped)
        .macOS { $0.frame(
            minWidth: 440, maxWidth: .infinity,
            minHeight: 220, maxHeight: .infinity) }
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

#Preview("iOS") {
    DataPreview {
        NavigationStack {
            EditTripFormHost(trip: .bedminsterToBeijing)
        }
    } modelContainer: {
        SampleModelContainer.sample()
    }
}

#Preview("macOS") {
    DataPreview {
        NavigationStack {
            EditTripFormHost(trip: .bedminsterToBeijing)
        }
        .frame(width: 900, height: 600)
    } modelContainer: {
        SampleModelContainer.sample()
    }
}
