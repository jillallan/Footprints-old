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

    var searchQuery: String = ""
    var completer: MKLocalSearchCompleter
    var completions = [MKLocalSearchCompletion]()

//    private var searchContinuations: [CheckedContinuation<[MKLocalSearchCompletion], Error>] = []
    private var searchContinuation: CheckedContinuation<[MKLocalSearchCompletion], Error>? {
        didSet {
            logger.info("did set \(String(describing: self.searchContinuation))")
        }
    }

    override init() {
        completer = MKLocalSearchCompleter()
        super.init()
        completer.delegate = self
    }

    @MainActor
    func updateSearchResults(query: String) async throws {

        guard !query.isEmpty else {
            return
        }

        completions = try await withCheckedThrowingContinuation { continuation in
            searchContinuation?.resume(throwing: CancellationError())
            searchContinuation = continuation
            completer.queryFragment = query
        }
    }
}

extension LocationSearchService: MKLocalSearchCompleterDelegate {
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: any Error) {
//        searchContinuations.forEach { $0.resume(throwing: error) }
        searchContinuation?.resume(throwing: error)
        searchContinuation = nil
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchContinuation?.resume(returning: completer.results)
//        searchContinuations.forEach { $0.resume(returning: completer.results) }
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
