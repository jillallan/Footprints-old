//
//  LocationEditorView.swift
//  Footprints
//
//  Created by Jill Allan on 17/06/2024.
//

import CoreLocation
import MapKit
import SwiftUI

struct LocationEditorView: View {
    @Bindable var step: Step
    @State private var locationSearchViewIsPresented: Bool = true
    @State var searchDetents: PresentationDetent = .medium
    @Environment(\.isSearching) private var isSearching

    var body: some View {
        Map(initialPosition: .region(step.region)) {
            Marker("", coordinate: step.coordinate)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        .sheet(isPresented: .constant(true)) {

            LocationSearchView(searchDetents: $searchDetents)

                .presentationDetents([.large, .medium, .fraction(0.2)], selection: $searchDetents)
                .presentationBackgroundInteraction(.enabled)
                .presentationContentInteraction(.automatic)
                .interactiveDismissDisabled()
//                .presentationDragIndicator(.visible)
        }
//        .interactiveDismissDisabled(true)
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    DataPreview {
        LocationEditorView(step: .bedminsterStation, searchDetents: .medium)
    } modelContainer: {
        SampleModelContainer.sample()
    }
}
