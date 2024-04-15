//
//  AppDetailColumn.swift
//  Footprints
//
//  Created by Jill Allan on 15/04/2024.
//

import SwiftUI

/// A detail view for the app splitview navigation.
/// Displays the selected app screen or instructions to navigate to a view
struct AppDetailColumn: View {
    /// The currently selected app screen
    var screen: AppScreen?

    var body: some View {
        Group {
            if let screen {
                screen.destination
            } else {
                ContentUnavailableView(
                    "Select a View",
                    systemImage: "airplane",
                    description: Text("Pick something from the list.")
                )
            }
        }
        .macOS { group in
            group
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background()
        }
    }
}

#Preview {
    AppDetailColumn()
}
