//
//  ViewController.swift
//  HomeTask_1
//
//  Created by wsr4 on 19.10.2021.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        }

}


class ViewController1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
    }
    

}


class ViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}


class CustomTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 6.62
        layer.borderColor = UIColor(red: 0.58, green: 0.639, blue: 0.722, alpha: 1).cgColor
        layer.borderWidth = 1.1
        

    }
}


class ViewController_task2: UIViewController {
    
    @IBOutlet weak var foreground: UIView!
    @IBOutlet weak var labelFirst: UILabel!
    @IBOutlet weak var labelSecond: UILabel!
    @IBAction func startButton(_ sender: Any) {
        foreground.isHidden = true
        labelFirst.isHidden = true
        labelSecond.isHidden = true
    }
    
    let idCell = "myCell"
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: idCell)
    }
}

extension ViewController_task2: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as! TableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Вчера"
        }
        else {
            return "Май 2022 года"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Routine")
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
    }
    
}

class ExactActivity: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
    }
    
}


class ViewControllerNum3: UIViewController {
    
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

extension ViewControllerNum3: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else {
            return
        }
        print("received user locations:", currentLocation.coordinate)
    }
}

extension ViewControllerNum3: MKMapViewDelegate {
    
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







