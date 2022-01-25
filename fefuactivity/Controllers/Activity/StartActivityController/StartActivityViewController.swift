import UIKit
import CoreLocation
import CoreData
import MapKit

private let image = UIImage(named: "Background")

private let identifier = "ActivityTypeCollectionViewCell"

// items for collection view
private let activitiesTypeData: [ActivityTypeCellViewModel] =
[
    ActivityTypeCellViewModel(activityType: "Велосипед", activityTypeImage: image ?? UIImage(), titleForManageState: "На велике"),
    ActivityTypeCellViewModel(activityType: "Бег", activityTypeImage: image ?? UIImage(), titleForManageState: "Бежим"),
    ActivityTypeCellViewModel(activityType: "Ходьба", activityTypeImage: image ?? UIImage(), titleForManageState: "Идем")
]

class StartActivityViewController: UIViewController {
    //MARK: - Set variables and outlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    // view for keep all states view, so interesting but when i embed some views in this container, i have a lot of warnings, it's unbeatiful
    @IBOutlet weak var statesContainer: UIView!
    
    // state when go to this view, before start
    @IBOutlet weak var startActivityStateView: UIView!
    
    @IBOutlet weak var toStartLabel: UILabel!
    @IBOutlet weak var startActivityButton: ActivityFEFUButton!
    @IBOutlet weak var listOfActivitiesType: UICollectionView!
    
    // state when user manage self activity tracking
    @IBOutlet weak var manageActivityStateView: UIView!
    @IBOutlet weak var typeOfActivityLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    
    // save for delete old routes
    private let CDController: CDActivityController = CDActivityController()
    private var previousRouteSegment: MKPolyline?
    private var currentDuration: TimeInterval = TimeInterval()
    private var startValueForTimer: Date?
    private var timer: Timer?
    
    private var activityDistance: CLLocationDistance = CLLocationDistance()
    private var activityDate: Date?
    private var activityDuration: TimeInterval = TimeInterval()
    private var activityType: String?
    
    private var timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    private var timeFormatterShort: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    private let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        return manager
    }()
    
    fileprivate var userLocation: CLLocation? {
        didSet {
            guard let userLocation = userLocation else {
                return
            }
            let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            
            if oldValue != nil {
                activityDistance += userLocation.distance(from: oldValue!)
            }
            
            distanceLabel.text = String(format: "%.2f км", activityDistance / 1000)
            
            mapView.setRegion(region, animated: true)
            
            userLocationsHistory.append(userLocation)
        }
    }
    
    // array for coordinates to update user route
    fileprivate var userLocationsHistory: [CLLocation] = [] {
        didSet {
            let coordinates = userLocationsHistory.map { $0.coordinate }
            
            // if user paused tracking, previous polyline not deleted
            if let previousRoute = previousRouteSegment, !userLocationsHistory.isEmpty {
                mapView.removeOverlay(previousRoute as MKOverlay)
                previousRouteSegment = nil
            }
            
            // if when user click pause we delete all of previous coordinates
            if userLocationsHistory.isEmpty {
                previousRouteSegment = nil
            }
            
            let route = MKPolyline(coordinates: coordinates, count: coordinates.count)
            route.title = "Ваш маршрут"
            
            previousRouteSegment = route
            
            mapView.addOverlay(route)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        self.title = "Новая активность"
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        listOfActivitiesType.dataSource = self
        listOfActivitiesType.delegate = self
        
        let nib = UINib(nibName: identifier, bundle: nil)
        listOfActivitiesType.register(nib, forCellWithReuseIdentifier: identifier)
        
        commonInit()
    }
    
    private func commonInit() {
        statesContainer.backgroundColor = .clear
        activityStateInit()
        manageStateInit()
    }
    
    private func activityStateInit() {
        // i think that i can set cornerRadius to container, but in design state views have different height, and i need2do this
        startActivityStateView.layer.cornerRadius = 25
        startActivityStateView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        startActivityStateView.isHidden = false
        
        toStartLabel.text = "Погнали? :)"
        
        startActivityButton.setTitle("Старт", for: .normal)
    }
    
    private func manageStateInit() {
        manageActivityStateView.layer.cornerRadius = 25
        manageActivityStateView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        typeOfActivityLabel.text = "Активность"
        distanceLabel.text = "0.00 км"
        timerLabel.text = "00:00:00"
        manageActivityStateView.isHidden = true
    }
    
    @IBAction func didStartTracking(_ sender: Any) {
        startActivityStateView.isHidden = true
        manageActivityStateView.isHidden = false
        
        activityDate = Date()
        startValueForTimer = Date()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        locationManager.startUpdatingLocation()
    }
    
    // formatting time for label
    @objc private func updateTimer() {
        let currentTime = Date().timeIntervalSince(startValueForTimer!)
        
        currentDuration = currentTime
        timerLabel.text = timeFormatter.string(from: currentTime + activityDuration)
    }
    
    @IBAction func didPauseTracking(_ sender: PauseToggleButton) {
        userLocationsHistory = []
        userLocation = nil
        
        sender.isSelected.toggle()
        if sender.isSelected {
            activityDuration += currentDuration
            currentDuration = TimeInterval()
            timer?.invalidate()
            
            locationManager.stopUpdatingLocation()
        } else {
            startValueForTimer = Date()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func didFinishTracking(_ sender: FinishActivityButton) {
        locationManager.stopUpdatingLocation()
        
        activityDuration += currentDuration
        timer?.invalidate()
        
        let startTime = timeFormatterShort.string(from: activityDate!)
        let endTime = timeFormatterShort.string(from: activityDate! + activityDuration)
        
        let activityType = activityType
        let startDate = dateFormatter.string(from: activityDate ?? Date())
        let distance = String(format: "%.2f км", activityDistance / 1000)
        let duration = timeFormatter.string(from: activityDuration)
        
        CDController.saveActivity(distance, duration!, activityType!, startDate, startTime, endTime)
        
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - CLLocationManagerDelegate

extension StartActivityViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else {
            return
        }
        
        userLocation = currentLocation
    }
}

//MARK: - MKMapViewDelegate

extension StartActivityViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let render = MKPolylineRenderer(polyline: polyline)
            
            render.fillColor = UIColor(named: "ButtonBackgroundColor")
            render.strokeColor = UIColor(named: "ButtonBackgroundColor")
            render.lineWidth = 5
            
            return render
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: "user_icon")
            
            let view = dequedView ?? MKAnnotationView(annotation: annotation, reuseIdentifier: "user_icon")
            
            view.image = UIImage(named: "UserLocation")
            return view
        }
        return nil
    }
}

//MARK: - UICollectionViewDataSource

extension StartActivityViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activitiesTypeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let activityTypeData = activitiesTypeData[indexPath.row]
        
        let dequeuedCell = listOfActivitiesType.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        guard let upcastedCell = dequeuedCell as? ActivityTypeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        upcastedCell.bind(activityTypeData)
        
        return upcastedCell
    }
}

// MARK: - UICollectionViewDelegate
extension StartActivityViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as?
            ActivityTypeCollectionViewCell {
            cell.cardView.layer.borderWidth = 2
            cell.cardView.layer.borderColor = UIColor(named: "ButtonBackgroundColor")?.cgColor
            
            activityType = cell.activityType
            typeOfActivityLabel.text = activityType
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ActivityTypeCollectionViewCell {
            cell.cardView.layer.borderWidth = 0
        }
    }
}
