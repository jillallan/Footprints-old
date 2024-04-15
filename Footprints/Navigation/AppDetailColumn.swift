//
//  AppDetailColumn.swift
//  Footprints
//
//  Created by Jill Allan on 15/04/2024.
//

import SwiftUI

struct AppDetailColumn: View {
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
