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

    func testTripView_whenIphonePotrait_TripsShownInOneColumn() {
        print(app.debugDescription)
        let scrollView = app.scrollViews
            .element(boundBy: 0)
            .children(matching: .other)
            .element(boundBy: 0)

        let scrollViewWidth = scrollView.frame.width

        let images = app.scrollViews.descendants(matching: .image)
        let imageWidths = images.allElementsBoundByIndex.map(\.frame.height)

        let averageWidth = imageWidths.reduce(0, +) / Double(imageWidths.count)
        XCTAssertEqual(
            scrollViewWidth,
            averageWidth,
            accuracy: 100.0,
            "scroll view width \(scrollViewWidth) should be approx equal to avg width of images: \(averageWidth)"
        )
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
    
    func testTripView_whenIpadPotrait_TripsShownInTwoColumns() {
        print(app.debugDescription)
        let scrollView = app.scrollViews
            .element(boundBy: 0)
            .children(matching: .other)
//            .children(matching: .other)
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
