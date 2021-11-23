
import UIKit
import CoreLocation
import MapKit

class ViewControllerdz3: UIViewController {

    

    @IBOutlet weak var mapView: MKMapView!
    
       
       let locationManager: CLLocationManager = {
           let manager = CLLocationManager()
           
           manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
           
           return manager
           
       }()
       
       fileprivate var userLocation: CLLocation? {
           didSet {
               guard let userLocation = userLocation else {
                   return
               }
               let region = MKCoordinateRegion(center: userLocation.coordinate,
                                               latitudinalMeters: 500,
                                               longitudinalMeters: 500)
               mapView.setRegion(region, animated: true)

               
               userLocationHistory.append(userLocation)
           }
       }
       
       fileprivate var userLocationHistory: [CLLocation] = [] {
           didSet {
               let coordinates = userLocationHistory.map { $0.coordinate }
               
               let route = MKPolyline(coordinates: coordinates, count: coordinates.count)
               route.title = "Ваш маршрут"
               
               mapView.addOverlay(route)
           }
       }
       
       private var userLocationIdentifier = "user_icon"
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           navigationItem.title = "Новая активность"
           
           locationManager.delegate = self
           locationManager.requestAlwaysAuthorization()
           locationManager.startUpdatingLocation()
           
           mapView.showsUserLocation = true
           mapView.delegate = self
       }
   }

   extension ViewControllerdz3: CLLocationManagerDelegate {
       
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let currentLocation = locations.first else {
               return
           }
           print("received user locations:", currentLocation.coordinate)
           userLocation = currentLocation
       }
   }

   extension ViewControllerdz3: MKMapViewDelegate {
       
       func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
           if let polyline = overlay as? MKPolyline {
               let render = MKPolylineRenderer(polyline: polyline)
               render.fillColor = UIColor.blue
               render.strokeColor = UIColor.blue
               render.lineWidth = 5
               
               return render
           }
           
           return MKOverlayRenderer(overlay: overlay)
       }
       
       func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
           if let annotation = annotation as? MKUserLocation {
               let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: userLocationIdentifier)
               
               let view = dequedView ?? MKAnnotationView(annotation: annotation, reuseIdentifier: userLocationIdentifier)
               view.image = UIImage(named: "ic_user_location")
               return view
           }
           return nil
       }
}
