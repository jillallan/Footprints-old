//
//  GetSizeModifier.swift
//  Footprints
//
//  Created by Jill Allan on 03/05/2024.
//

// fatbobman

import Foundation
import SwiftUI

struct GetSizeModifier: ViewModifier {
    @Binding var size: CGSize
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    // Use size instead of geometry as geometry does not conform to equatable
                    let proxySize = geometry.size
                    Color.clear
                    // Use task id instead of on change
                    // as this should have the most updated info in cases where
                    // the size negogitation takes mupltiple rounds
                        .task(id: geometry.size) {
                            // Filter out any negative values
                            let width = max(proxySize.width, 0)
                            let height = max(proxySize.height, 0)
                            $size.wrappedValue = CGSize(width: width, height: height)
                        }
                }
            )
    }
}
