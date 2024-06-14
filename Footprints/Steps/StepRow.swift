//
//  StepRow.swift
//  Footprints
//
//  Created by Jill Allan on 14/06/2024.
//

import SwiftUI

struct StepRow: View {
    let step: Step

    var body: some View {
        VStack {
            Text(step.timestamp.formatted(date: .abbreviated, time: .shortened))
        }
    }
}

#Preview {
    DataPreview {
        StepRow(step: .bedminsterStation)
    } modelContainer: {
        SampleModelContainer.sample()
    }
}
