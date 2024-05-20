//
//  CalendarUITestPicker.swift
//  FootprintsUITests
//
//  Created by Jill Allan on 14/05/2024.
//

import XCTest

final class CalendarUITestPicker: XCTestCase {

    func pickDate(app: XCUIApplication, newDate: Date) {
        let today = Date.now

        // get "show year picker", check it exists and tap to open it
        let showYearPicker = app.buttons["Show year picker"]
        XCTAssert(showYearPicker.isHittable)
        showYearPicker.tap()

        // get year picker with todays year label
        // check it exists and adjust to random date year
        let yearPickerWheel = app.pickerWheels[DateFormatter.year.string(from: today)]
        XCTAssert(yearPickerWheel.isHittable)
        yearPickerWheel.adjust(toPickerWheelValue: DateFormatter.year.string(from: newDate))

        // get year picker with todays month label
        // check it exists and adjust to random date month
        let monthPickerWheel = app.pickerWheels[DateFormatter.monthLong.string(from: today)]
        XCTAssert(monthPickerWheel.isHittable)
        monthPickerWheel.adjust(toPickerWheelValue: DateFormatter.monthLong.string(from: newDate))

        // get "hide year picker", check it exists and tap to close it
        let hideYearPicker = app.buttons["Hide year picker"]
        XCTAssert(hideYearPicker.isHittable)
        hideYearPicker.tap()

        // Get date in format to match calendar day picker, get day button in calendar
        // check it exists and tap to select it
        let newDateString = newDate.formatted(Date.FormatStyle().weekday(.wide).month(.wide).day(.defaultDigits))
        let dayOfMonth = app.buttons[newDateString]
        XCTAssert(dayOfMonth.isHittable)
        dayOfMonth.tap()

        // dismiss calendar picker
        app.buttons["PopoverDismissRegion"].tap()

    }
}
