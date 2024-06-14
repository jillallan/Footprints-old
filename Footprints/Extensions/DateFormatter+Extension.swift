//
//  DateFormatter+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 14/05/2024.
//

import Foundation

extension DateFormatter {
    static let defaultDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()

    static func date(fromDefault string: String) -> Date {
        return DateFormatter.defaultDateFormat.date(from: string) ?? Date.now
    }

    static let dayOrdinaldd: DateFormatter = {
        let dateFormatter = DateFormatter()
        let localeIdentifier = NSLocale.current.identifier
        dateFormatter.locale = Locale(identifier: localeIdentifier)
        dateFormatter.setLocalizedDateFormatFromTemplate("dd")
        dateFormatter.locale = Locale.autoupdatingCurrent

        return dateFormatter
    }()

    static let dayOrdinald: DateFormatter = {
        let dateFormatter = DateFormatter()
        let localeIdentifier = NSLocale.current.identifier
        dateFormatter.locale = Locale(identifier: localeIdentifier)
        dateFormatter.setLocalizedDateFormatFromTemplate("dd")
        dateFormatter.locale = Locale.autoupdatingCurrent

        return dateFormatter
    }()

    static let monthLong: DateFormatter = {
        let dateFormatter = DateFormatter()
        let localeIdentifier = NSLocale.current.identifier
        dateFormatter.locale = Locale(identifier: localeIdentifier)
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
        dateFormatter.locale = Locale.autoupdatingCurrent

        return dateFormatter
    }()

    static let year: DateFormatter = {
        let dateFormatter = DateFormatter()
        let localeIdentifier = NSLocale.current.identifier
        dateFormatter.locale = Locale(identifier: localeIdentifier)
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy")
        dateFormatter.locale = Locale.autoupdatingCurrent

        return dateFormatter
    }()
}
