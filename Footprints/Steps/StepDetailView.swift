//
//  StepDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 16/06/2024.
//

import MapKit
import SwiftUI

struct StepDetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var step: Step
    @Bindable var trip: Trip
    @State var timestamp: Date

    let isNew: Bool
    @State private var isLocationEditorViewPresented: Bool = false

    var body: some View {
        List {
            Button {
                isLocationEditorViewPresented.toggle()
            } label: {
                Map(initialPosition: .region(MKCoordinateRegion(
                    center: step.coordinate,
                    span: MKCoordinateSpan.sample
                ))) {
                    Marker("", coordinate: step.coordinate)
                }
                .frame(height: 200)
            }
            .buttonStyle(.plain)

            DatePicker("Date", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])

            Image(.china)
                .resizable()
                .scaledToFit()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $isLocationEditorViewPresented) {
#if !os(watchOS)
            LocationEditorView(step: step)
#endif
        }

//        .sheet(isPresented: $isLocationEditorViewPresented) {
//#if !os(watchOS)
//            LocationEditorView(step: step)
//            #endif
//        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    saveStep()
                    dismiss()
                }
            }
        }
    }

    init(step: Step, trip: Trip, isNew: Bool) {
        _step = Bindable(wrappedValue: step)
        _trip = Bindable(wrappedValue: trip)
        self.isNew = isNew
        _timestamp = State(wrappedValue: step.timestamp)
    }

    func saveStep() {
        if isNew {
            step.timestamp = timestamp
            trip.steps.append(step)
        } else {
            step.timestamp = timestamp
        }
    }
}

#Preview {
    DataPreview {
        StepDetailView(step: .bedminsterStation, trip: Trip.bedminsterToBeijing, isNew: false)
    } modelContainer: {
        SampleModelContainer.sample()
    }

}
