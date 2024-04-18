//
//  View+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 15/04/2024.
//

import Foundation
import SwiftUI

extension View {

    /// Add view modifier that applies the specified modifier to a view in macOS only
    /// - Parameter modifier: The modifier to add to the view
    /// - Returns: For MacOS returns the modified view, otherwise it returns the original view
    ///
    /// Use this to attach a modifier to a view in MacOS only
    func macOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(macOS)
        return modifier(self)
        #else
        return self
        #endif
    }
}
