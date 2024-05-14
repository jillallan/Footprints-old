//
//  TripUITestHelper.swift
//  FootprintsUITests
//
//  Created by Jill Allan on 14/05/2024.
//

import XCTest

final class TripUITestHelper: XCTestCase {

    func addTripTitle(app: XCUIApplication, title: String) {
        let titleTextField = app.textFields["Name your trip"]
        XCTAssert(titleTextField.isHittable)
        titleTextField.tap()
        titleTextField.typeText(title)
    }

    func addStartDate(app: XCUIApplication, startDate: Date) {
        let calendarPicker = CalendarUITestPicker()

        // get startDatePicker, check it exists, tap to open it
        let startDatePicker = app.datePickers.element(boundBy: 0)
        XCTAssert(startDatePicker.isHittable)
        startDatePicker.tap()

        calendarPicker.pickDate(app: app, newDate: startDate)

        let startDatePickerValue = startDatePicker.children(matching: .button).firstMatch.value

        XCTAssertEqual(
            // swiftlint:disable:next force_cast
            startDatePickerValue as! String,
            startDate.formatted(date: .abbreviated, time: .omitted)
        )
    }

    func addEndDate(app: XCUIApplication, endDate: Date) {
        let calendarPicker = CalendarUITestPicker()

        // get endDatePicker, check it exists, tap to open it
        let endDatePicker = app.datePickers.element(boundBy: 1)
        XCTAssert(endDatePicker.isHittable)
        endDatePicker.tap()

        calendarPicker.pickDate(app: app, newDate: endDate)

        print(app.debugDescription)

        let endDatePickerValue = endDatePicker.children(matching: .button).firstMatch.value

        XCTAssertEqual(
            // swiftlint:disable:next force_cast
            endDatePickerValue as! String,
            endDate.formatted(date: .abbreviated, time: .omitted)
        )
    }

    func launchAddTripView(app: XCUIApplication) {
        let addTripButton = app.buttons["Add Trip"]

        XCTAssert(addTripButton.isHittable)
        addTripButton.tap()

        let addTripNavigationTitle = app.navigationBars.staticTexts["Add Trip"]
        XCTAssert(addTripNavigationTitle.exists)
    }

    func addTrip(app: XCUIApplication, title: String) {
        launchAddTripView(app: app)
        addTripTitle(app: app, title: title)

        let saveButton = app.buttons["Save"]
        XCTAssert(saveButton.isHittable)
        saveButton.tap()
    }

    func addTrip(app: XCUIApplication, title: String, startDate: Date, endDate: Date) {
        launchAddTripView(app: app)
        addTripTitle(app: app, title: title)
        addStartDate(app: app, startDate: startDate)
        addEndDate(app: app, endDate: endDate)

        let saveButton = app.buttons["Save"]
        XCTAssert(saveButton.isHittable)
        saveButton.tap()
    }

    func whenTripDetailView_returnToTripView(app: XCUIApplication) {
        let backButton = app.navigationBars.element(boundBy: 0).buttons["Trips"]
        if backButton.waitForExistence(timeout: 1) {
            XCTAssert(backButton.isHittable)
            backButton.tap()
        }
    }

    func whenInTripView_deleteData(app: XCUIApplication) {
        app.buttons["Clear"].tap()

        let tripCount = app.scrollViews
            .otherElements
            .buttons
            .count

        XCTAssertEqual(tripCount, 0, "There should be 0 trips after deleting all data.")
    }
}
