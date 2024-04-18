//
//  Date+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 18/04/2024.
//

import Foundation

extension Date {
    /// Creates a date from a string
    /// - Parameters:
    ///   - string: A date represented by a string
    ///   - format: The format the string should be in, default is yyyy-MM-dd HH:mm:ss
    /// - Returns: A date
    ///
    /// Calling the function with the default format
    /// ```swift
    /// Date.from(string: "2024-01-01 12:00:00")
    /// ```
    ///
    /// Passing a custom format
    /// ```swift
    /// Date.from(string: "2024-01-01", format: "yyyy-MM-dd")
    /// ```
    static func from(string: String, format: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format

        let date = dateFormatter.date(from: string)!
        return date
    }
}
