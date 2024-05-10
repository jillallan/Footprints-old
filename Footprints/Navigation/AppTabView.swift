//
//  AppTabView.swift
//  Footprints
//
//  Created by Jill Allan on 15/04/2024.
//

import SwiftUI

/// The navigation view for iPhones and apple TV
///
/// For iPhones and TV, tab bar navigation is used,
/// for ipad and mac split view navigation is used
struct AppTabView: View {
    /// The currently selected app screen
    @Binding var selection: AppScreen?

    var body: some View {
        TabView(selection: $selection) {
            ForEach(AppScreen.allCases) { screen in
                screen.destination
                    .tag(screen as AppScreen?)
                    .tabItem { screen.label }
            }
        }
    }
}

#Preview {
    AppTabView(selection: .constant(.trips))
        .modelContainer(SampleModelContainer.sample())
        .environmentObject(NavigationController.preview)
}
