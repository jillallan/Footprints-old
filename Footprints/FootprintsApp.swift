//
//  FootprintsApp.swift
//  Footprints
//
//  Created by Jill Allan on 15/04/2024.
//

import SwiftUI

@main
struct FootprintsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 750, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
        }
        .modelContainer(for: [Trip.self])
    }
}
