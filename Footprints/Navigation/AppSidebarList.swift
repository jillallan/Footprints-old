//
//  AppSidebarList.swift
//  Footprints
//
//  Created by Jill Allan on 15/04/2024.
//

import SwiftUI

/// A sidebar list for the app splitview navigation
struct AppSidebarList: View {
    /// The currently selected app screen
    @Binding var selection: AppScreen?

    var body: some View {
        List(AppScreen.allCases, selection: $selection) { screen in
            NavigationLink(value: screen) {
                screen.label
            }
        }
        .navigationTitle("Journal")
    }
}

#Preview {
    AppSidebarList(selection: .constant(.trips))
}
