import UIKit
import MapKit
import CoreLocation

protocol ActivityRouteDelegate: AnyObject {
    func activityDidCreate()
}

class StartActivityController: UIViewController {

    weak var delegate: ActivityRouteDelegate?

    private var latitude: Double = 500
    private var longitude: Double = 500
    private var deviceLocationIdentifier: String = "DeviceLocationActive"

    private var activityCollectionData: [ActivityCollectionCellModel] = []
    private var activityType: ActivityCollectionCellModel?
    private var previousRoute: MKOverlay?
    private var lastDuration: TimeInterval? = nil
    private var timer: Timer = Timer()
    private var timerStartsAt: Date?

    private var startDate: Date = Date()
    private var distance: CLLocationDistance = CLLocationDistance() {
        didSet {
            distanceLabel.text = String(format: "%.2f км", distance / 1000)
        }
    }
    private var duration: TimeInterval = TimeInterval()
    
    private let timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()

    private let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        return manager
    }()

    private var deviceLocation: CLLocation? {
        didSet {
            if let deviceLocation = deviceLocation {
                let region = MKCoordinateRegion(center: deviceLocation.coordinate, latitudinalMeters: latitude, longitudinalMeters: longitude)
                
                mapView.setRegion(region, animated: true)

                deviceRoute.append(deviceLocation)
                if oldValue != nil {
                    distance += deviceLocation.distance(from: oldValue!)
                }
            }
        }
    }
    private var deviceRoute: [CLLocation] = [] {
        didSet {
            let coordinates = deviceRoute.map { $0.coordinate }
            
            if let prevRoute: MKOverlay = previousRoute, !deviceRoute.isEmpty {
                mapView.removeOverlay(prevRoute as MKOverlay)
                previousRoute = nil
            }
            
            if deviceRoute.isEmpty {
                previousRoute = nil
            }
            
            let route = MKPolyline(coordinates: coordinates, count: coordinates.count)
            route.title = "Ваш маршрут"
            mapView.addOverlay(route)
            
            previousRoute = route
        }
    }

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var typesCollection: UICollectionView!
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var proccessView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        proccessView.isHidden = true
        proccessView.layer.cornerRadius = 25
        startView.isHidden = false
        startView.layer.cornerRadius = 25
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        typesCollection.delegate = self
        typesCollection.dataSource = self

        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        Activities.types { activityTypes in
            DispatchQueue.main.async {
                self.activityCollectionData = activityTypes
                self.typesCollection.reloadData()
            }
        } reject: { error in
            print(error)
        }
    }
    
    @IBAction func startHandler(_ sender: Any) {
        locationManager.startUpdatingLocation()

        startDate = Date()
        timerStartsAt = Date()

        startView.isHidden = true
        proccessView.isHidden = false
        typeLabel.text = activityType?.name
        
        createTimer()
    }

    @IBAction func stopHandler(_ sender: Any) {
        locationManager.stopUpdatingLocation()
        
        timer.invalidate()
        
        var activityDuration = duration
        if let lstDuration: TimeInterval = lastDuration {
            activityDuration += lstDuration
        }

        let coreData = FEFUCoreDataContainer.instance
        let activity = CDActivity(context: coreData.context)
        activity.distance = distanceLabel.text!
        activity.duration = activityDuration.duration()
        activity.startDate = startDate
        activity.endDate = Date()
        activity.type = activityType?.name ?? ""
        coreData.saveContext()

        activityDidCreate()

        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func toggleHandler(_ sender: UIButton) {
        if (sender.isSelected) {
            sender.setBackgroundImage(UIImage(systemName: "pause.circle.fill"), for: .normal)

            locationManager.startUpdatingLocation()

            timerStartsAt = Date()
            createTimer()
        } else {
            sender.setBackgroundImage(UIImage(systemName: "play.circle.fill"), for: .normal)

            deviceRoute = []
            deviceLocation = nil
            
            locationManager.stopUpdatingLocation()

            if let lstDuration: TimeInterval = lastDuration {
                duration += lstDuration
            }
            lastDuration = nil
            timer.invalidate()
        }
        sender.isSelected.toggle()
    }

    private func createTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timer.tolerance = 0.1
    }

    @objc func updateTimer() {
        let lastInterval = Date().timeIntervalSince(timerStartsAt!)

        lastDuration = lastInterval

        durationLabel.text = timeFormatter.string(from: lastInterval + duration)
    }
}

extension StartActivityController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else {
            return
        }
        
        deviceLocation = currentLocation
    }
}

extension StartActivityController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.fillColor = UIColor.blue
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 5
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MKUserLocation else {
            return nil
        }

        let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: deviceLocationIdentifier)

        let view = dequedView ?? MKAnnotationView(annotation: annotation, reuseIdentifier: deviceLocationIdentifier)

        view.image = UIImage(named: "DeviceLocationActive")
        return view
    }
}

extension StartActivityController: ActivityRouteDelegate {
    func activityDidCreate() {
        delegate?.activityDidCreate()
    }
}

extension StartActivityController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activityCollectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = activityCollectionData[indexPath.row]

        let dequeuedCell = typesCollection.dequeueReusableCell(withReuseIdentifier: "ActivityCollectionCell", for: indexPath)

        guard let cell = dequeuedCell as? ActivityCollectionCellController else {
            return UICollectionViewCell()
        }

        cell.bind(cellData)
        if (cellData.id == activityType?.id) {
            cell.focus()
        }

        return cell
    }
}

extension StartActivityController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        activityType = activityCollectionData[indexPath.row]

        guard let cell = collectionView.cellForItem(at: indexPath) as?
            ActivityCollectionCellController else {
            return
        }
        cell.focus()
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ActivityCollectionCellController {
            cell.unfocus()
        }
    }
}
