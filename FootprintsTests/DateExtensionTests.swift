//
//  Date+ExtensionTests.swift
//  FootprintsTests
//
//  Created by Jill Allan on 18/04/2024.
//

import XCTest
@testable import Footprints

final class DateExtensionTests: XCTestCase {

    func testDate_whenParsingDateString_returnsDateThatMatchesTheDateString() {
        // if
        let dateString = "2023-10-10"
        let format = "yyyy-MM-dd"

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: dateString)!

        // when
        let testDate = Date.from(string: dateString, format: format)

        // then
        XCTAssertEqual(
            testDate,
            date,
            "when converting a string to a date the date should be the same as the date string"
        )
    }

    func testDate_whenParsingDateStringWithDefaultFormat_returnsDateThatMatchesTheDateString() {
        // if
        let dateString = "2023-10-10 00:00:00"

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)!

        // when
        let testDate = Date.from(string: dateString)

        // then
        XCTAssertEqual(
            testDate,
            date,
            "when converting a string to a date the date should be the same as the date string"
        )
    }
}
