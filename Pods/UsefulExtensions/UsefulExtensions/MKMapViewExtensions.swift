//
//  MKMapViewExtensions.swift
//  UsefulExtensions
//
//  Created by Andrea Bellotto on 29/01/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView{
    
    public func centerMapOnLocation(location: CLLocation, radius:CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  radius * 2.0, radius * 2.0)
        self.setRegion(coordinateRegion, animated: true)
    }
}
