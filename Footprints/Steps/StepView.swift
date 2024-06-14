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
                StepRow(step: step)
            }
        }
    }
}

#Preview {
    DataPreview {
        StepView(trip: .bedminsterToBeijing)
    } modelContainer: {
        SampleModelContainer.sample()
    }

}
