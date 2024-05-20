//
//  AddTripViewUITests.swift
//  FootprintsUITests
//
//  Created by Jill Allan on 14/05/2024.
//

import XCTest

final class AddTripViewUITests: XCTestCase {
    var app: XCUIApplication!
    var device: XCUIDevice!
    var tripHelper: TripUITestHelper!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        device = XCUIDevice.shared
        tripHelper = TripUITestHelper()
        #if !os(macOS)
        device.orientation = .portrait
        #endif
        app.launch()
        continueAfterFailure = false

        tripHelper.whenInTripView_deleteData(app: app)
    }

    func testAddTripView_whenNoTitleEntered_saveButtonIsDisabled() {
        tripHelper.launchAddTripView(app: app)

        let saveButton = app.buttons["Save"]
        XCTAssert(saveButton.isHittable)
        XCTAssert(!saveButton.isEnabled)

        
    }

    func testAddTripView_whenTitleEntered_saveButtonIsEnabled() {
        tripHelper.launchAddTripView(app: app)
        tripHelper.addTripTitle(app: app, title: String.randomWord())

        let saveButton = app.buttons["Save"]
        XCTAssert(saveButton.isHittable)
        XCTAssert(saveButton.isEnabled)
    }

    func testAddTripView_endDateIsGreaterOrEqualToStartDate() {
        tripHelper.launchAddTripView(app: app)

        let startDate = Date.randomBetween(
            start: Date.now.addingTimeInterval(1000000),
            end: Date.now.addingTimeInterval(30000000)
        )
        tripHelper.addStartDate(app: app, startDate: startDate)

        let startDatePickerValue = app
            .datePickers
            .element(boundBy: 0)
            .children(matching: .button)
            .firstMatch.value as! String    // swiftlint:disable:this force_cast
        let endDatePickerValue = app
            .datePickers
            .element(boundBy: 1)
            .children(matching: .button)
            .firstMatch.value as! String    // swiftlint:disable:this force_cast

        let endDate = Date.from(string: endDatePickerValue, format: "dd MMM yyyy")

        XCTAssertGreaterThanOrEqual(endDate, startDate)
    }

    func testAddTripView_startDateIsLessThanOrEqualToEndDate() {
        tripHelper.launchAddTripView(app: app)

        let endDate = Date.randomBetween(
            start: Date.now.addingTimeInterval(-30000000),
            end: Date.now.addingTimeInterval(-1000000)
        )
        tripHelper.addEndDate(app: app, endDate: endDate)

        let startDatePickerValue = app
            .datePickers.element(boundBy: 0)
            .children(matching: .button)
            .firstMatch.value as! String    // swiftlint:disable:this force_cast
        let endDatePickerValue = app
            .datePickers.element(boundBy: 1)
            .children(matching: .button)
            .firstMatch.value as! String    // swiftlint:disable:this force_cast

        let startDate = Date.from(string: startDatePickerValue, format: "dd MMM yyyy")

        XCTAssertGreaterThanOrEqual(endDate, startDate)
        XCTAssertLessThanOrEqual(startDate, endDate)
    }

    func testAddTripView_whenSaveButtonPressed_SavesTripAndOpensTripDetailView() throws {
        let title = String.randomWord()
        let startDate = Date.randomBetween(start: "2020-01-01", end: "2023-01-01", format: "yyyy-MM-dd")
        let endDate = Date.randomBetween(start: "2023-01-01", end: "2024-01-01", format: "yyyy-MM-dd")

        tripHelper.addTrip(app: app, title: title, startDate: startDate, endDate: endDate)

        XCTAssert(app.staticTexts[title].exists)

        tripHelper.whenTripDetailView_returnToTripView(app: app)
    }
}
