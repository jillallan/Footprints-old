//
//  OSLog+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 03/05/2024.
//

import Foundation
import OSLog

extension Logger {
    init(category: String) {
        self.init(subsystem: Bundle.main.bundleIdentifier!, category: category)
    }
}
