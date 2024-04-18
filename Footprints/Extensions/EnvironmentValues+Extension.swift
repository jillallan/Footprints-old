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
    ///
    /// This is used to apply the tab bar navigation on iPhone and TV platforms.
    /// Otherwise split view navigation is used
    var prefersTabNavigation: Bool {
        get { self[PrefersTabNavigationEnvironmentKey.self] }
        set { self[PrefersTabNavigationEnvironmentKey.self] = newValue }
    }
}

/// The default navigation is split view navigation
struct PrefersTabNavigationEnvironmentKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

#if os(iOS)

extension PrefersTabNavigationEnvironmentKey: UITraitBridgedEnvironmentKey {

    /// Reads the user interface idiom from the current UITraitCollection.
    /// Required by the UITraitBridgedEnvironmentKey protocol
    /// - Parameter traitCollection: UITraitCollection of the device
    /// - Returns: True if the device is an iphone or tv, false for all other platforms
    static func read(from traitCollection: UITraitCollection) -> Bool {
        return traitCollection.userInterfaceIdiom == .phone || traitCollection.userInterfaceIdiom == .tv
    }

    /// Required by the UITraitBridgedEnvironmentKey protocol
    /// - Parameters:
    ///   - mutableTraits: UIMutableTraits
    ///   - value: Bool
    ///
    ///   Writes the user interface idiom to the current UITraitCollection.
    ///   Not implemented for this extension
    static func write(to mutableTraits: inout UIMutableTraits, value: Bool) {
        // Do not write
    }
}
#endif
