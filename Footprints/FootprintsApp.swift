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

    var body: some Scene {
        WindowGroup {
//            TestScrollView()
            ContentView()
                .environmentObject(navigationController)
                .macOS { view in
                    view
                        .frame(minWidth: 750, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
                }
        }
        .modelContainer(for: [Trip.self], isUndoEnabled: true)
    }
}
