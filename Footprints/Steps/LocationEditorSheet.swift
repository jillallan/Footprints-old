//
//  LocationEditorSheet.swift
//  Footprints
//
//  Created by Jill Allan on 17/06/2024.
//

import SwiftUI

struct LocationEditorSheet: View {
    @State var currentLocationName: String = "The Rising Sun, Pensford"
    @Environment(\.isSearching) private var isSearching
    @Binding var searchDetents: PresentationDetent

    var body: some View {
        List {
            Text(currentLocationName)
        }
        .onChange(of: isSearching) {
            if isSearching {
                searchDetents = .large
            } else {
                searchDetents = .medium
            }
        }
    }
}

#Preview {
    LocationEditorSheet(searchDetents: .constant(.medium))
}
