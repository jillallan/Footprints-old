//
//  LocalSearchServiceBeta.swift
//  Footprints
//
//  Created by Jill Allan on 05/07/2024.
//

import Foundation
import MapKit

@Observable
final class LocalSearchServiceBeta: NSObject {
    var completer: MKLocalSearchCompleter

    let (stream, continuation) = AsyncThrowingStream.makeStream(
        of: [MKLocalSearchCompletion].self,
        bufferingPolicy: .bufferingNewest(1)
    )

    override init() {
        completer = MKLocalSearchCompleter()
        super.init()
        completer.delegate = self
    }

    @MainActor
    func provideCompletionSuggestions(for query: String) async throws -> [MKLocalSearchCompletion] {
        guard !query.isEmpty else {
            return []
        }

        completer.queryFragment = query

        for try await searchCompletions in stream {
            return searchCompletions
        }
        return []
    }
}

extension LocalSearchServiceBeta: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let suggestedCompletions = completer.results
        continuation.yield(suggestedCompletions)
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: any Error) {
        continuation.finish(throwing: error)
    }
}
