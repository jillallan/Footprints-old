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
        HStack {
            Image(systemName: "car")
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.indigo, lineWidth: 2)
                }
            VStack {
                Text(step.timestamp.formatted(date: .abbreviated, time: .shortened))
            }
            Spacer()
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
