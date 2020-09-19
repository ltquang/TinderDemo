//
//  MapViewController.swift
//  TinderDemo
//
//  Created by macOS on 9/18/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class MapViewController: DetailBaseController {
    var latitude: CGFloat = 0
    var longtitude: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        latitude = CGFloat(Double(userModel.location.latitude) ?? 0)
        longtitude = CGFloat(Double(userModel.location.longitude) ?? 0)
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(latitude),
                                              longitude: CLLocationDegrees(longtitude),
                                              zoom: 1.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.settings.scrollGestures = false
        mapView.accessibilityIdentifier = "myMapView"
        mapView.accessibilityElementsHidden = false
        self.view.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude),
                                                 longitude: CLLocationDegrees(longtitude))
        marker.title = userModel.location.address
        marker.snippet = userModel.location.address
        marker.accessibilityLabel = "myMarker"
        marker.map = mapView
    }
}
