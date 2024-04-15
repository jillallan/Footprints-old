//
//  NavigationUITests.swift
//  FootprintsUITests
//
//  Created by Jill Allan on 15/04/2024.
//

import XCTest

final class NavigationUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    func testContentView_whenViewLoadsOnPhoneOrTV_tabbarShouldBeHittable() throws {
        if #available(iOS 13.0, tvOS 13.0, *) {
#if os(iOS)
            let device = UIDevice.current.userInterfaceIdiom

            if device == .phone || device == .tv {
                let tabBar = app.tabBars.firstMatch
                XCTAssert(tabBar.isHittable, "Should return true if \(device.rawValue)")
            }
#endif
        }
    }

    func testContentView_whenViewLoadsOnPad_sidebarButtonShouldBeHittable() throws {
#if os(iOS)
        let device = UIDevice.current.userInterfaceIdiom

        if device == .pad {
            let sidebar = app.navigationBars.buttons["ToggleSidebar"]
            XCTAssert(sidebar.isHittable, "Should return true if \(device.rawValue)")
        }
#endif
    }

    func testContentView_whenViewLoadsOnMac_sidebarButtonShouldExist() throws {
#if os(macOS)
        let sidebar = app.buttons["Hide Sidebar"]
        XCTAssert(sidebar.exists)
#endif
    }
}
