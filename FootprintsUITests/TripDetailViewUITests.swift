//
//  TripDetailViewUITests.swift
//  FootprintsUITests
//
//  Created by Jill Allan on 13/05/2024.
//

import XCTest

final class TripDetailViewUITests: XCTestCase {

    var app: XCUIApplication!
    var device: XCUIDevice!

    override func setUpWithError() throws {
        app = XCUIApplication()
        device = XCUIDevice.shared
        #if !os(macOS)
        device.orientation = .portrait
        #endif
        app.launch()
        continueAfterFailure = false
    }

    func testAccessibility() throws {
        continueAfterFailure = true
        try app.performAccessibilityAudit()
    }

    func testTripDetailView_EditingATrip_NewDetailsShowInTripDetailView() throws {
        let tripButton = app
            .scrollViews
            .otherElements
            .buttons
            .element(boundBy: 0)
        XCTAssert(tripButton.isHittable)
        tripButton.tap()

        let editButton = app
            .navigationBars
            .element(boundBy: 0)
            .buttons["Edit"]
        XCTAssert(editButton.isHittable)
        editButton.tap()

        let tripTitleTextField = app
            .collectionViews
            .textFields["Name your trip"]
        XCTAssert(tripTitleTextField.isHittable)
        tripTitleTextField.tap()

        tripTitleTextField.clearAndTypeText(text: "New Title")

        let saveButton = app
            .navigationBars
            .element(boundBy: 0)
            .buttons["Save"]
        XCTAssert(saveButton.isHittable)
        saveButton.tap()

//        let tripsButton = app
//            .navigationBars.element(boundBy: 0).buttons["Trips"]
//        XCTAssert(tripsButton.isHittable)
//        tripsButton.tap()

        let tripTitle = app.navigationBars["New Title"]
        XCTAssert(tripTitle.exists)
    }

    func testTripDetailView_EditingATrip_NewDetailsShowInTripView() throws {

    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
