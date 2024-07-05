//
//  LocationSearchView.swift
//  Footprints
//
//  Created by Jill Allan on 17/06/2024.
//

import MapKit
import OSLog
import SwiftUI

struct LocationSearchView: View {
    let logger = Logger(category: String(describing: LocationSearchService.self))

    @State var searchQuery = ""
    @Binding var searchDetents: PresentationDetent
    #if !os(watchOS)
    @State private var locationSearchService = LocationSearchService()
//    let locationCompletionClosure: (MKLocalSearchCompletion) -> Void
    #endif
    @State private var isSearchResultViewPresented: Bool = false
    @State private var selectedCompletion: MKLocalSearchCompletion?
    @Environment(\.dismiss) private var dismiss

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
                        Button {
                            if completion.subtitle == "Search Nearby" {
                                isSearchResultViewPresented.toggle()
                            } else {
                                selectedCompletion = completion
                            }
                            searchDetents = .medium
                            logger.info("location suggestion selected")
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(completion.description)
                                    Text(completion.title)
                                    Text(completion.subtitle)
                                }
                            }
                        }
                        .buttonStyle(.plain)

                    }
                }
                .onChange(of: searchQuery) {
                    Task {
                        await updateSearchResults()
                    }
                }
                .sheet(item: $selectedCompletion) {
                    searchDetents = .large
                } content: { completion in
                    Text(completion.title)
                        .presentationDetents([.large, .medium])
                }

                .sheet(isPresented: $isSearchResultViewPresented) {
                    searchDetents = .large
                } content: {
                    List {
                        Text("Result 1")
                        Text("Result 2d")
                        Text("Result 3")
                    }
                    .presentationDetents([.medium])
                }

#endif
                .navigationTitle("Location Search")
        }
    }

#if !os(watchOS)
    @MainActor
    func updateSearchResults() async {
        do {
            try await locationSearchService.updateSearchResults(query: searchQuery)
        } catch {
//            logger.error("Failed to fetch search results: \(error.localizedDescription)")
        }
    }
#endif
}

#Preview {
    LocationSearchView(searchDetents: .constant(.large))
//    LocationSearchView(searchQuery: "Shops", searchDetents: .constant(.large)) { _ in
//        // TODO:
//    }
//        .environment(LocationSearchService.preview)
}
