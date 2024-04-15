//
//  View+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 15/04/2024.
//

import Foundation
import SwiftUI

extension View {

    /// Add view modifier for macOS only
    /// - Parameter modifier: The modifier to add
    /// - Returns: Some view
    func macOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(macOS)
        return modifier(self)
        #else
        return self
        #endif
    }
}
