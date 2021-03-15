//
//  MapViewController.swift
//  Spot
//
//  Created by suhyeon on 2021/02/07.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // MARK: Variables
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 50000 // 이 지역은 50000m의 거리에 따라 동, 서, 남, 북에 걸쳐 있음
    var longitudeData: String = ""
    var latitudeData: String = ""
    let manager = CLLocationManager()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "사고발생 지점"
        
        let longitude = (longitudeData as NSString).doubleValue
        let latitude = (latitudeData as NSString).doubleValue
        findAccidentRegion(longitude: longitude, latitude: latitude)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest //battery
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func findAccidentRegion(longitude: Double, latitude: Double) {
        // add annotation
        let annotation = MKPointAnnotation()
        let accidentCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.coordinate = accidentCoordinate
        mapView.addAnnotation(annotation)
        // showing region with radious
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            render(location)
        }
    }
    
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }

}

