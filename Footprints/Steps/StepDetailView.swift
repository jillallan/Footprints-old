//
//  StepDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 16/06/2024.
//

import MapKit
import SwiftUI

struct StepDetailView: View {
    @Bindable var step: Step
    @State private var isLocationEditorViewPresented: Bool = false

    var body: some View {
        List {
            Button {
                isLocationEditorViewPresented.toggle()
            } label: {
                Map(initialPosition: .region(MKCoordinateRegion(center: step.coordinate, span: MKCoordinateSpan.sample))) {
                    Marker("", coordinate: step.coordinate)
                }
                .frame(height: 200)
            }
            .buttonStyle(.plain)

            DatePicker("Date", selection: $step.timestamp, displayedComponents: [.date, .hourAndMinute])

            Image(.china)
                .resizable()
                .scaledToFit()
        }
        
        .sheet(isPresented: $isLocationEditorViewPresented) {

            LocationEditorView(step: step)
        }
    }
}

#Preview {
    DataPreview {
        StepDetailView(step: .bedminsterStation)
    } modelContainer: {
        SampleModelContainer.sample()
    }

}
