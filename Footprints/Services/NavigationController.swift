//
//  NavigationController.swift
//  Footprints
//
//  Created by Jill Allan on 04/05/2024.
//

import Foundation
import SwiftUI

class NavigationController: ObservableObject {
    @Published var navigationPath: NavigationPath

    init() {
        navigationPath = NavigationPath()
        print(navigationPath)
    }
}

extension NavigationController {
    // Decorated with nonisolated(unsafe) as this
    // is only for previews
//    nonisolated(unsafe)
    static var preview: NavigationController = {
        NavigationController()
    }()
}
