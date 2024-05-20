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
    var tripHelper: TripUITestHelper!

    override func setUpWithError() throws {
        app = XCUIApplication()
        device = XCUIDevice.shared
        tripHelper = TripUITestHelper()
        #if !os(macOS)
        device.orientation = .portrait
        #endif
        app.launch()
        continueAfterFailure = false
    }

//    func testAccessibility() throws {
//        tripHelper.launchAddTripView(app: app)
//        continueAfterFailure = true
//        try app.performAccessibilityAudit()
//    }

    func testTripDetailView_EditingATrip_NewDetailsShowInTripDetailView() {
        tripHelper.whenInTripView_loadData(app: app)

        let newTitle = String.randomWord()
        editTripAndWaitForExistence(title: newTitle) {
            let newTitleText = app.navigationBars[newTitle]
            XCTAssert(newTitleText.exists)
        }
    }

    func testTripDetailView_EditingATrip_NewDetailsShowInTripView() throws {
        tripHelper.whenInTripView_loadData(app: app)

        let newTitle = String.randomWord()
        editTripAndWaitForExistence(title: newTitle) {
            let backButton = app.buttons["Trips"]
            XCTAssert(backButton.exists, "The back button should exist and is hittables")
            backButton.tap()

            let newTitleText = app.scrollViews.staticTexts[newTitle]
            XCTAssert(newTitleText.exists, "Trip title should exist")
        }
    }

    func editTripAndWaitForExistence(title: String, closure: () -> Void) {
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

        tripTitleTextField.clearAndTypeText(text: title)

        let saveButton = app
            .navigationBars
            .element(boundBy: 0)
            .buttons["Save"]
        if saveButton.waitForExistence(timeout: 1) {
            XCTAssert(saveButton.isHittable)
            saveButton.tap()
            closure()
        }
    }
}
