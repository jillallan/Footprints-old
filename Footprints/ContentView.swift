//
//  ContentView.swift
//  Footprints
//
//  Created by Jill Allan on 15/04/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    @State private var selection: AppScreen? = .trips

    var body: some View {
        if prefersTabNavigation {
            AppTabView(selection: $selection)
        } else {
            NavigationSplitView {
                AppSidebarList(selection: $selection)
                    .navigationSplitViewColumnWidth(min: 100, ideal: 200, max: 300)
            } detail: {
                AppDetailColumn(screen: selection)
            }
        }
    }
}

#Preview {
    ContentView()
}
