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
    #if !os(watchOS)
    @State private var locationSearchService = LocationSearchService()
    #endif

//    @Environment(\.isSearching) private var isSearching

    var body: some View {
        NavigationStack {
            LocationEditorSheet(searchDetents: $searchDetents)
#if !os(watchOS)
                .searchable(
                    text: $searchQuery,
                    placement: .navigationBarDrawer(displayMode: .always)
                )
                .searchSuggestions {
                    ForEach(locationSearchService.completions) { completion in
                        VStack(alignment: .leading) {
                            Text(completion.title)
                            Text(completion.subtitle)
                        }
                    }
                }
                .onChange(of: searchQuery) {
                    Task {
                        await updateSearchResults()
                    }
                }
#endif
                .navigationTitle("Location Search")

        }
    }

    @MainActor
    func updateSearchResults() async {
        do {
            try await locationSearchService.updateSearchResults(query: searchQuery)
        } catch {
//            logger.error("Failed to fetch search results: \(error.localizedDescription)")
        }
    }
}

#Preview {
    LocationSearchView(searchDetents: .constant(.medium))
//        .environment(LocationSearchService.preview)
}
