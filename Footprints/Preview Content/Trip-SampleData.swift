//
//  Trip-SampleData.swift
//  Footprints
//
//  Created by Jill Allan on 16/04/2024.
//

import Foundation

extension Trip {
    /// A data formatter to format the dates in the sample data
    static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }

    @MainActor
    /// A sample trip
    static let bedminsterToBeijing = Trip(
        title: "Bedminster to Beijing",
//        startDate: Date.from(string: "2016/07/28 08:06:00"),
        startDate: dateFormatter.date(from: "2016/07/28 08:06:00")!,
//        endDate: Date.from(string: "2016/09/02 12:00:00"),
        endDate: dateFormatter.date(from: "2016/09/02 12:00:00")!,
        isAutoTrackingOn: false
    )

    @MainActor
    /// A sample trip
    static let mountains = Trip(
        title: "Mountains",
//        startDate: Date.from(string: "2016/09/03 08:06:00"),
        startDate: dateFormatter.date(from: "2016/07/28 08:06:00")!,
//        endDate: Date.from(string: "2016/09/30 12:00:00"),
        endDate: dateFormatter.date(from: "2016/09/02 12:00:00")!,
        isAutoTrackingOn: false
    )
    
    @MainActor
    /// A sample trip
    static let wales = Trip(
        title: "Anglesey",
//        startDate: Date.from(string: "2016/09/03 08:06:00"),
        startDate: dateFormatter.date(from: "2024/04/01 08:06:00")!,
//        endDate: Date.from(string: "2016/09/30 12:00:00"),
        endDate: dateFormatter.date(from: "2023/04/07 12:00:00")!,
        isAutoTrackingOn: false
    )
}
