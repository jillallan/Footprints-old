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

        tripHelper.whenInTripView_deleteData(app: app)
    }

//    func testAccessibility() throws {
//        continueAfterFailure = true
//        try app.performAccessibilityAudit()
//    }

    func testTripView_whenAddTripButtonTapped_BringsUpAddTripSheet() {
        let addTripButton = app.buttons["Add Trip"]

        XCTAssert(addTripButton.isHittable)
        addTripButton.tap()

        let addTripNavigationTitle = app.navigationBars.staticTexts["Add Trip"]
        XCTAssert(addTripNavigationTitle.exists)
    }

//    func testTripView_WhenTripSwipedAndDeleted_DeletesTrip() {
////        testAddTripView_whenNewTripAddedAndBackButtonPressd_IncreasesTripCount()
//        let trips = app.collectionViews.element(boundBy: 0).cells
//        XCTAssertEqual(trips.count, 1)
//
//        trips.element(boundBy: 0).swipeLeft()
//        print(app.debugDescription)
//
//        let deleteButton = app.buttons["Delete"]
//        if deleteButton.waitForExistence(timeout: 2) {
//            XCTAssert(deleteButton.isHittable)
//            deleteButton.tap()
//
//            XCTAssertEqual(trips.count, 0)
//        }
//    }

    func testTripView_AddingATrip_ShowsNewTripinTripDetailView() {
        let tripHelper = TripUITestHelper()
        let tripTitle = String.randomWord()
        tripHelper.addTrip(app: app, title: tripTitle)

        let tripTitleText = app.staticTexts[tripTitle]
        XCTAssert(tripTitleText.exists, "The title text should exist")
    }

    func testTripView_AddingATrip_NewTripShowsInTripView() {
        let tripHelper = TripUITestHelper()
        let tripTitle = String.randomWord()
//        tripHelper.addTrip(app: app, title: tripTitle)
        tripHelper.addTripAndWaitForExistence(app: app, title: tripTitle) {
            let backButton = app.buttons["Trips"]
            XCTAssert(backButton.exists, "The back button should exist and is hittables")
            backButton.tap()

            
        }
    }

    func testTripView_whenNewTripAddedAndBackButtonPressd_IncreasesTripCount() {
        // if
        let startTripCount = app
            .scrollViews
            .otherElements
            .buttons
            .count

        XCTAssertEqual(startTripCount, 0)

        let title = String.randomWord()
        tripHelper.addTrip(app: app, title: title)

        // when
        let backButton = app.navigationBars[title].buttons["Trips"]
        if backButton.waitForExistence(timeout: 1) {
            XCTAssert(backButton.isHittable)
            backButton.tap()

            // then
            let endTripCount = app
                .scrollViews
                .otherElements
                .buttons
                .count
            XCTAssertEqual(endTripCount, startTripCount + 1)
        }
    }

//    func testTripView_whenIphoneLandscape_TripsShownInTwoColumns() {
//        print(app.debugDescription)
//#if !os(macOS)
//        device.orientation = .landscapeLeft
//#endif
//        let scrollView = app.scrollViews
//            .element(boundBy: 0)
//            .children(matching: .other)
//            .element(boundBy: 0)
//
//        let scrollViewWidth = scrollView.frame.width
//
//        let images = app.scrollViews.descendants(matching: .image)
//        let imageWidths = images.allElementsBoundByIndex.map(\.frame.height)
//
//        let averageWidth = imageWidths.reduce(0, +) / Double(imageWidths.count) * 2
//        XCTAssertEqual(
//            scrollViewWidth,
//            averageWidth,
//            accuracy: 100.0,
//            "scroll view width \(scrollViewWidth) should be approx equal to avg width of images: \(averageWidth)"
//        )
//    }

}
