//
//  LocationService.swift
//  Park.ly
//
//  Created by Roman Subrychak on 12/25/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
	
	static let instance = LocationService()
	
	private override init() {
		super.init()
		self.locationManager.delegate = self
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
		self.locationManager.distanceFilter = 50
		self.locationManager.startUpdatingLocation()
	}
	
	var locationManager = CLLocationManager()
	var currentLocation: CLLocationCoordinate2D?
	
}

extension LocationService: CLLocationManagerDelegate {
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		self.currentLocation = locationManager.location?.coordinate
		
	}
}
