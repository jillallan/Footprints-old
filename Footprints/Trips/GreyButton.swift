//
//  GreyButton.swift
//  Footprints
//
//  Created by Jill Allan on 06/05/2024.
//

import SwiftUI

struct GreyButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.5))
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
}

extension ButtonStyle where Self == GreyButton {
    static var greyButton: Self { Self() }
}
