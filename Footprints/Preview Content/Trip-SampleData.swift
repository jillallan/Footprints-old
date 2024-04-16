//
//  Trip-SampleData.swift
//  Footprints
//
//  Created by Jill Allan on 16/04/2024.
//

import Foundation

extension Trip {
    static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }
    
    static let bedminsterToBeijing = Trip(
        title: "Bedminster to Beijing",
//        startDate: Date.from(string: "2016/07/28 08:06:00"),
        startDate: dateFormatter.date(from: "2016/07/28 08:06:00")!,
//        endDate: Date.from(string: "2016/09/02 12:00:00"),
        endDate: dateFormatter.date(from: "2016/09/02 12:00:00")!,
        isAutoTrackingOn: false
    )
    
    static let mountains = Trip(
        title: "Mountains",
//        startDate: Date.from(string: "2016/09/03 08:06:00"),
        startDate: dateFormatter.date(from: "2016/07/28 08:06:00")!,
//        endDate: Date.from(string: "2016/09/30 12:00:00"),
        endDate: dateFormatter.date(from: "2016/09/02 12:00:00")!,
        isAutoTrackingOn: false
    )
}
