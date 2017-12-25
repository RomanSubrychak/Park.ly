//
//  ViewController.swift
//  Park.ly
//
//  Created by Roman Subrychak on 12/25/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
	
	@IBOutlet weak var parkBtn : UIButton!
	@IBOutlet weak var mapView : MKMapView!
	
	var parkedCarAnnotation: ParkingSpot?
	let regionRadius: CLLocationDistance = 500

	override func viewDidLoad() {
		super.viewDidLoad()
		
		mapView.delegate = self
		checkLocationAuthorizationStatus()
	}
	
	@IBAction func parkBtnPressed(_ sender: UIButton) {
		if mapView.annotations.count == 1 {
			mapView.addAnnotation(parkedCarAnnotation!)
			
			parkBtn.setImage(UIImage(named: "foundCar.png"), for: .normal)
		} else {
			mapView.removeAnnotations(mapView.annotations)
			parkBtn.setImage(UIImage(named: "parkCar.png"), for: .normal)
		}
		
		centerMapOnLocation(location: LocationService.instance.locationManager.location!)
	}
	
	func checkLocationAuthorizationStatus() {
		if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
			mapView.showsUserLocation = true
			LocationService.instance.locationManager.delegate? = self
			LocationService.instance.locationManager.desiredAccuracy = kCLLocationAccuracyBest
			LocationService.instance.locationManager.startUpdatingLocation()
		} else {
			LocationService.instance.locationManager.requestWhenInUseAuthorization()
		}
	}
	
	func centerMapOnLocation(location: CLLocation) {
		let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
		mapView.setRegion(coordinateRegion, animated: true)
	}
}

extension ViewController: MKMapViewDelegate {
	
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		
		if let annotation = annotation as? ParkingSpot {
			
			let identifier = "pin"
			
			let view: MKPinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
			
			view.canShowCallout = true
			view.animatesDrop = true
			view.pinTintColor = .orange
			view.calloutOffset = CGPoint(x: -8, y: -3)
			view.rightCalloutAccessoryView = UIButton.init(type: .detailDisclosure) as UIView
			
			return view
		} else {
			return nil
		}
	}
	
	func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
		
		let location = view.annotation as! ParkingSpot
		
		let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
		
		location.mapItem(location: (parkedCarAnnotation?.coordinate)!).openInMaps(launchOptions: launchOptions)
	
	}
}

extension ViewController: CLLocationManagerDelegate {
	
	func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
		
		centerMapOnLocation(location: CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude))
		
		let locationServiceCoordinate = LocationService.instance.locationManager.location!.coordinate
		
		parkedCarAnnotation = ParkingSpot(title: "My Parking Spot", locationName: "Tap the 'i' for GPS", coordinate: CLLocationCoordinate2D(latitude: locationServiceCoordinate.latitude, longitude: locationServiceCoordinate.longitude))
	}
}
