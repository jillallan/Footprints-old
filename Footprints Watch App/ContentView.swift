//
//  ContentView.swift
//  FootprintsWatch Watch App
//
//  Created by Jill Allan on 15/04/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TripView2()
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleModelContainer.sample())
}
