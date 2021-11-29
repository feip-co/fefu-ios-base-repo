//
//  ActivityBeginViewController.swift
//  fefuactivity
//
//  Created by soFuckingHot on 26.11.2021.
//

import UIKit
import CoreLocation
import MapKit

class ActivityBeginViewController: UIViewController {

    private let userLocationIdentifier = "user_icon"
    // outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // for deleting
    private var prevSegment: MKPolyline?
    
    private let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
        mapView.tag = 1
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    
    }


   var userLocation: CLLocation? {
        didSet {
            if let userLocation = userLocation {
                let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                
                mapView.setRegion(region, animated: true)
                
                userLocationsHistory.append(userLocation)
            }
        }
    }
    
    
    fileprivate var userLocationsHistory: [CLLocation] = [] {
        didSet {
            let coordinates = userLocationsHistory.map { $0.coordinate }
            
            
            
            let route = MKPolyline(coordinates: coordinates, count: coordinates.count)
            route.title = "Ваш маршрут"
            
            prevSegment = route
            
            mapView.addOverlay(route)
        }
    }
    
}

extension ActivityBeginViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print("im here")
        //print(locations)
        guard let currentLocation = locations.first else {
            return
        }
        userLocation = currentLocation
        
    }
}


extension ActivityBeginViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let render = MKPolylineRenderer(polyline: polyline)
            
            render.fillColor = UIColor(named: "BlueBtnColor")
            render.strokeColor = UIColor(named: "BlueBtnColor")
            render.lineWidth = 5
            
            return render
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? MKUserLocation {
            let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: userLocationIdentifier)
                
            let view = dequedView ?? MKAnnotationView(annotation: annotation, reuseIdentifier: userLocationIdentifier)
            
            view.image = UIImage(named: "UserLocation")
            return view
        }
        return nil
    }
}
