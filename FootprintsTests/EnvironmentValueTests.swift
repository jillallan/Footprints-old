//
//  EnvironmentValueTests.swift
//  FootprintsTests
//
//  Created by Jill Allan on 15/04/2024.
//

import XCTest
@testable import Footprints

final class EnvironmentValueTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPrefersTabNavigationEnvironmentKey_whenPhoneOrTV_shouldReturnTrue() throws {
#if os(iOS)
        let userInterfaceIdioms = [
            "phone": UITraitCollection.init(userInterfaceIdiom: .phone),
            "tv": UITraitCollection.init(userInterfaceIdiom: .tv)
        ]

        for (key, value) in userInterfaceIdioms {
            let prefersTabNavigation = PrefersTabNavigationEnvironmentKey.read(from: value)
            XCTAssertTrue(prefersTabNavigation, "Should return true if \(key)")
        }
#endif
    }

    func testPrefersTabNavigationEnvironmentKey_whenNotPhoneOrTV_shouldReturnFalse() throws {
#if os(iOS)
        let userInterfaceIdioms = [
            "pad": UITraitCollection.init(userInterfaceIdiom: .pad),
            "carPlay": UITraitCollection.init(userInterfaceIdiom: .carPlay),
            "mac": UITraitCollection.init(userInterfaceIdiom: .mac),
            "unspecified": UITraitCollection.init(userInterfaceIdiom: .unspecified),
            "vision": UITraitCollection.init(userInterfaceIdiom: .vision)
        ]

        for (key, value) in userInterfaceIdioms {
            let prefersTabNavigation = PrefersTabNavigationEnvironmentKey.read(from: value)
            XCTAssertFalse(prefersTabNavigation, "Should return false if \(key)")
        }
#endif
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
