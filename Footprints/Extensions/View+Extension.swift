//
//  View+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 15/04/2024.
//

import Foundation
import SwiftUI

extension View {

    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    ///
    /// Example
    /// ```swift
    /// Text("Hello world!")
    ///     .if(true) { view in
    ///         view
    ///             .padding()
    ///     }
    /// ```
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    /// A view modifier that applies the specified modifier to a view in macOS only
    /// - Parameter modifier: The modifier to add to the view
    /// - Returns: For macOS returns the modified view, otherwise it returns the original view
    ///
    /// Use this to attach a modifier to a view in macOS only
    /// ```swift
    /// Text("Hello world!")
    ///     .macOS { view in
    ///         view
    ///             .padding()
    ///     }
    /// ```
    func macOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(macOS)
        return modifier(self)
        #else
        return self
        #endif
    }

    /// A view modifier that applies the specified modifier to a view in watchOS only
    /// - Parameter modifier: The modifier to add to the view
    /// - Returns: For watchOS returns the modified view, otherwise it returns the original view
    ///
    /// Use this to attach a modifier to a view in watchOS only
    /// ```swift
    /// Text("Hello world!")
    ///     .watchOS { view in
    ///         view
    ///             .padding()
    ///     }
    /// ```
    func watchOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(watchOS)
        return modifier(self)
        #else
        return self
        #endif
    }

    /// A view modifier that applies the specified modifier to a view in iOS only
    /// - Parameter modifier: The modifier to add to the view
    /// - Returns: For iOS returns the modified view, otherwise it returns the original view
    ///
    /// Use this to attach a modifier to a view in iOS only
    /// ```swift
    /// Text("Hello world!")
    ///     .iOS { view in
    ///         view
    ///             .padding()
    ///     }
    /// ```
    func iOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(iOS)
        return modifier(self)
        #else
        return self
        #endif
    }

    /// A view modifier that returns the size of the view it's attached too
    ///
    /// It will keep a binding updated with the size
    /// - Parameter size: The binding to pass to the modifier to keep updated
    /// - Returns: Returns the view it's attached to unmodified
    func getSize(_ size: Binding<CGSize>) -> some View {
        modifier(GetSizeModifier(size: size))
    }
}
