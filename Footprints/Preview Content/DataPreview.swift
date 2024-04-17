//
//  DataPreview.swift
//  Footprints
//
//  Created by Jill Allan on 17/04/2024.
//

import SwiftUI
import SwiftData

/// A struct to access sample data within previews
struct DataPreview<Content: View>: View {
    /// The view to pass Persistent Models into
    var content: () -> Content
    
    /// The model container to use to access the data
    let container: ModelContainer

    var body: some View {
        content()
    }

    
    /// Initializes a DataPreview to pass data into xcode previews
    /// - Parameters:
    ///   - content: The view to pass Persistent Models into
    ///   - modelContainer: The model container to use to access the data
    init(
        @ViewBuilder content: @escaping () -> Content,
        modelContainer: @escaping () throws -> ModelContainer
    ) {
        self.content = content
        do {
            self.container = try MainActor.assumeIsolated(modelContainer)
        } catch {
            fatalError("Failed to create the preview model container: \(error.localizedDescription)")
        }
    }
}
