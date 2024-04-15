//
//  EnvironmentValues+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 15/04/2024.
//

import Foundation
import SwiftUI

extension EnvironmentValues {

    /// An environment key indicating if the device prefers tab navigation
    var prefersTabNavigation: Bool {
        get { self[PrefersTabNavigationEnvironmentKey.self] }
        set { self[PrefersTabNavigationEnvironmentKey.self] = newValue }
    }
}

// Default value
struct PrefersTabNavigationEnvironmentKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

#if os(iOS)

// If iOS return true for phone and tv, false for ipad,
// will not be run for mac, so default value of false stands, as per above
extension PrefersTabNavigationEnvironmentKey: UITraitBridgedEnvironmentKey {

    /// Reads the user interface idiom from the current UITraitCollection.
    /// Required by the UITraitBridgedEnvironmentKey protocol
    /// - Parameter traitCollection: UITraitCollection of the device
    /// - Returns: True if the device is an iphone or tv, false for all other platforms
    static func read(from traitCollection: UITraitCollection) -> Bool {
        return traitCollection.userInterfaceIdiom == .phone || traitCollection.userInterfaceIdiom == .tv
    }

    /// Writes the user interface idiom to the current UITraitCollection.
    /// Required by the UITraitBridgedEnvironmentKey protocol
    /// - Parameters:
    ///   - mutableTraits: UIMutableTraits
    ///   - value: Bool
    static func write(to mutableTraits: inout UIMutableTraits, value: Bool) {
        // Do not write
    }
}
#endif
