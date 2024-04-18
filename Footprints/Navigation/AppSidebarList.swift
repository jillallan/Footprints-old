//
//  AppSidebarList.swift
//  Footprints
//
//  Created by Jill Allan on 15/04/2024.
//

import SwiftUI

/// The navigation view for iPad and Mac
///
/// For iPhones and TV, tab bar navigation is used,
/// for ipad and mac split view navigation is used
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
