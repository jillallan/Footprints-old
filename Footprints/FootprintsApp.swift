//
//  FootprintsApp.swift
//  Footprints
//
//  Created by Jill Allan on 15/04/2024.
//

import SwiftUI

@main
struct FootprintsApp: App {
    @StateObject var navigationController = NavigationController()
    @State private var locationHandler = LocationHandler()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigationController)
                .macOS { view in
                    view
                        .frame(minWidth: 750, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
                }
        }
        .modelContainer(for: [Trip.self], isUndoEnabled: true)
        .environment(locationHandler)
    }
}
