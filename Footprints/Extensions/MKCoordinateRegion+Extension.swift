//
//  MKCoordinateRegion+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 16/06/2024.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    static let sample = MKCoordinateRegion(
        center: CLLocationCoordinate2D.sample,
        span: MKCoordinateSpan.sample
    )
}
