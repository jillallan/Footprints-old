//
//  TripDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 06/05/2024.
//

import MapKit
import SwiftUI

struct TripDetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(LocationHandler.self) private var locationHandler
    @Bindable var trip: Trip
    @State private var isEditViewPresented: Bool = false
    @State private var isAddStepViewPresented: Bool = false

    var body: some View {
        TripMap(trip: trip)
            .safeAreaInset(edge: .bottom) {
                StepView(trip: trip)
                    .frame(height: 300)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Edit") {
                        isEditViewPresented.toggle()
                    }
                }
            }
            .sheet(isPresented: $isEditViewPresented) {
                TripEditorView(trip: trip)
            }
            .sheet(isPresented: $isAddStepViewPresented) {

                StepDetailView(step: Step(timestamp: Date.now)) //, isNewStep: true)
            }
            .overlay {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button("Add Step", systemImage: "plus") {
                            Task {

                                do {
                                    try await locationHandler.getCurrentLocation()
                                } catch {

                                }

                            }
                            isAddStepViewPresented.toggle()

                        }
                        .font(.largeTitle)
                        .labelStyle(.iconOnly)
                        .frame(width: 80, height: 80)
                        .background(Color.indigo)
                        .foregroundStyle(Color.white)
                        .clipShape(Circle())
                        .padding()

                    }
                }
                .ignoresSafeArea()
            }
            .navigationTitle(trip.title)
#if os(iOS)
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbar(.hidden, for: .tabBar)
#endif
    }
}

#Preview("Standard") {
    DataPreview {
        NavigationStack {
            TripDetailView(trip: .bedminsterToBeijing)
        }
    } modelContainer: {
        SampleModelContainer.sample()
    }
}

#Preview("No steps") {
    DataPreview {
        NavigationStack {
            TripDetailView(trip: .anglesey)
        }
    } modelContainer: {
        SampleModelContainer.sample()
    }
}

#Preview("Editing title") {
    DataPreview {
        NavigationStack {
            TripDetailView(trip: .bedminsterToBeijing)
        }
    } modelContainer: {
        SampleModelContainer.sample()
    }
}
