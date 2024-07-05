//
//  MapItemSearchService.swift
//  Footprints
//
//  Created by Jill Allan on 05/07/2024.
//

import MapKit
import OSLog
import SwiftUI

@Observable
class MapItemSearchService {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: MapItemSearchService.self)
    )

    var searchQuery = Debouncer(initialValue: "", delay: 3.0)
    var searchResults: [MKMapItem] = []

    @MainActor
    func search(for query: String, in region: MKCoordinateRegion) async {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.region = region
        searchRequest.naturalLanguageQuery = query

        let search = MKLocalSearch(request: searchRequest)

        do {
            let searchResponse = try await search.start()
            self.searchResults = searchResponse.mapItems
        } catch {
            logger.error("Unable to perform search result: \(error.localizedDescription)")
        }
    }

    @MainActor
    func search(for completion: MKLocalSearchCompletion, in region: MKCoordinateRegion) async {
        let searchRequest = MKLocalSearch.Request(completion: completion)
        searchRequest.region = region

        let search = MKLocalSearch(request: searchRequest)

        do {
            let searchResponse = try await search.start()
            self.searchResults = searchResponse.mapItems
        } catch {
            logger.error("Unable to perform search result: \(error.localizedDescription)")
        }
    }

    @MainActor
    func pointsOfInterestSearch(in region: MKCoordinateRegion) async {

        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.370792, longitude: -2.546549), span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        let pointOfInterestRequest = MKLocalPointsOfInterestRequest(coordinateRegion: region)

        let search = MKLocalSearch(request: pointOfInterestRequest)

        do {
            let searchResponse = try await search.start()
            self.searchResults = searchResponse.mapItems
        } catch {
            logger.error("Unable to perform search result: \(error.localizedDescription)")
        }
    }
}

extension MKLocalSearch.Response: @unchecked Sendable { }

extension MKLocalSearch: @unchecked Sendable { }
