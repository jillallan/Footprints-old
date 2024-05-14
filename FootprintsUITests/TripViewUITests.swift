//
//  TripViewUITests.swift
//  FootprintsUITests
//
//  Created by Jill Allan on 01/05/2024.
//

import XCTest

final class TripViewUITests: XCTestCase {
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

    func testTripView_AddingATrip_ShowsNewTripinTripDetailView() {
        
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

        tripTitleTextField.clearAndEnterText(text: "New Title")

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

    func testTripView_AddingATrip_NewTripShowsInTripView() {

        
    }

    func testTripView_whenIphoneLandscape_TripsShownInTwoColumns() {
        print(app.debugDescription)
#if !os(macOS)
        device.orientation = .landscapeLeft
#endif
        let scrollView = app.scrollViews
            .element(boundBy: 0)
            .children(matching: .other)
            .element(boundBy: 0)

        let scrollViewWidth = scrollView.frame.width

        let images = app.scrollViews.descendants(matching: .image)
        let imageWidths = images.allElementsBoundByIndex.map(\.frame.height)

        let averageWidth = imageWidths.reduce(0, +) / Double(imageWidths.count) * 2
        XCTAssertEqual(
            scrollViewWidth,
            averageWidth,
            accuracy: 100.0,
            "scroll view width \(scrollViewWidth) should be approx equal to avg width of images: \(averageWidth)"
        )
    }

}
