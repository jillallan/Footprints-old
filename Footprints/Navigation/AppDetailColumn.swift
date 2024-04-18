//
//  AppDetailColumn.swift
//  Footprints
//
//  Created by Jill Allan on 15/04/2024.
//

import SwiftUI

/// The navigation detail view for iPad and Mac
///
/// For iPhones and TV, tab bar navigation is used,
/// for ipad and mac split view navigation is used
/// This displays the selected detail view or instructions to navigate to a view
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
