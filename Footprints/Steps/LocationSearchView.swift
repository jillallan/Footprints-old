//
//  LocationSearchView.swift
//  Footprints
//
//  Created by Jill Allan on 17/06/2024.
//

import SwiftUI

struct LocationSearchView: View {
    @State var searchQuery = ""
    @Binding var searchDetents: PresentationDetent

//    @Environment(\.isSearching) private var isSearching

    var body: some View {
        NavigationStack {
            LocationEditorSheet(searchDetents: $searchDetents)
            #if !os(watchOS)
            .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always))
            #endif
            .navigationTitle("Location Search")
            .searchSuggestions {
                ForEach(11..<20) { num in
                    Text("This item is \(num)")
                }
            }
        }
    }
}

#Preview {
    LocationSearchView(searchDetents: .constant(.medium))
}
