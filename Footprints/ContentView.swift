//
//  ContentView.swift
//  Footprints
//
//  Created by Jill Allan on 15/04/2024.
//

import SwiftUI

struct ContentView: View {
    /// An environment value indicating if the device prefers tab navigation
    ///
    /// If false the device should use split view navigtion
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    @State private var selection: AppScreen? = .trips
    @State var columnVisibility: NavigationSplitViewVisibility = .all
    @State var width: CGFloat = .zero

    var body: some View {
        if prefersTabNavigation {
            AppTabView(selection: $selection)
        } else {
            GeometryReader { geometry in
                NavigationSplitView(columnVisibility: $columnVisibility) {
                    AppSidebarList(selection: $selection)
                        .navigationSplitViewColumnWidth(min: 100, ideal: 200, max: 300)
                        .macOS { $0.toolbar(removing: .sidebarToggle) }
                } detail: {
                    AppDetailColumn(screen: selection)
                        .frame(minWidth: 400)
                }
                .onAppear {
                    width = geometry.size.width
                }
                .onChange(of: geometry.size.width) {
                    width = geometry.size.width
                }
                .onChange(of: width) {
                    if width < 800 {
                        columnVisibility = .detailOnly
                    }
                    if width > 800 {
                        columnVisibility = .automatic
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleModelContainer.sample())
}
