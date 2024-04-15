//
//  AppScreen.swift
//  Footprints
//
//  Created by Jill Allan on 15/04/2024.
//

import SwiftUI

// Create a enum for the label and destination of each app screen that
// can be selected from either the tabbar view in iOS
// or split view in macOS.
// This way we can reference them in those views
// instead of declaring them twice

/// An enum of the main screens to display in the app navigation
enum AppScreen: String, Codable, Hashable, Identifiable, CaseIterable {
    case trips
//    case steps
//    case locations
//    case stats
//    case settings

    /// The id of the app screen cases
    ///
    /// This is required for conformance to the identifiable protocol
    var id: AppScreen { self }
}

extension AppScreen {
    /// Label to display in the navigation view for the corresponding view
    @ViewBuilder
    var label: some View {
        switch self {
        case .trips:
            Label("Trips", systemImage: "airplane")
//        case .steps:
//            Label("Steps", systemImage: "figure.walk")
//        case .locations:
//            Label("Locations", systemImage: "mappin.and.ellipse")
//        case .stats:
//            Label("Statistics", systemImage: "chart.bar.xaxis")
//        case .settings:
//            Label("Settings", systemImage: "gear")
        }
    }

    /// View to navigate to from the main navigation
    @ViewBuilder
    var destination: some View {
        switch self {
        case .trips:
            TripView()
//        case .steps:
//            StepView()
//        case .locations:
//            LocationView()
//        case .stats:
//            StatisticsView()
//        case .settings:
//            SettingsView()
        }
    }
}
