//
//  LocationSearchService.swift
//  Footprints
//
//  Created by Jill Allan on 21/06/2024.
//

import Foundation
import MapKit
import OSLog

@Observable
class LocationSearchService: NSObject {
    let logger = Logger(category: String(describing: LocationSearchService.self))

    var completer: MKLocalSearchCompleter
    var completions = [MKLocalSearchCompletion]()

    private var searchContinuation: CheckedContinuation<[MKLocalSearchCompletion], Error>?

    override init() {
        completer = MKLocalSearchCompleter()
        super.init()
        completer.delegate = self
    }

    @MainActor
    func updateSearchResults(query: String) async throws {
        completions = try await withCheckedThrowingContinuation { continuation in
            searchContinuation = continuation
            completer.queryFragment = query
        }
    }
}

extension LocationSearchService: MKLocalSearchCompleterDelegate {
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: any Error) {
        searchContinuation?.resume(throwing: error)
        searchContinuation = nil
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchContinuation?.resume(returning: completer.results)
        searchContinuation = nil
    }
}

extension LocationSearchService {
    @MainActor
    static var preview: LocationSearchService = {
        LocationSearchService()
    }()
}

extension MKLocalSearchCompletion: Identifiable { }

