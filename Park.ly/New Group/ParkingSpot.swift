//
//  ParkingSpot.swift
//  Park.ly
//
//  Created by Roman Subrychak on 12/25/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class ParkingSpot: NSObject, MKAnnotation {
	
	let title: String?
	let locationName: String?
	let coordinate: CLLocationCoordinate2D
	
	init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
		
		self.title = title
		self.locationName = locationName
		self.coordinate = coordinate
	}
	
	var subtitle: String? {
		return locationName
	}
	
	func mapItem(location: CLLocationCoordinate2D) -> MKMapItem {
		
		let addressDirectory = [String(CNPostalAddressStreetKey): subtitle]
		
		let placemark = MKPlacemark(coordinate: location, addressDictionary: addressDirectory)
		
		let mapItem = MKMapItem(placemark: placemark)
		mapItem.name = title
		
		return mapItem
	}
}
