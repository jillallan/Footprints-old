//
//  StepView.swift
//  Footprints
//
//  Created by Jill Allan on 14/06/2024.
//

import SwiftUI

struct StepView: View {
    let trip: Trip

    var body: some View {
        List {
            ForEach(trip.steps) { step in
                NavigationLink(value: step) {
                    StepRow(step: step)
                }

            }
            Text("Add step")
        }
        .navigationDestination(for: Step.self) { step in
            StepDetailView(step: step)
        }
        .listStyle(.plain)
    }
}

#Preview {
    DataPreview {
        NavigationStack{
            StepView(trip: .bedminsterToBeijing)
        }
    } modelContainer: {
        SampleModelContainer.sample()
    }

}
