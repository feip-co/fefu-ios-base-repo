import UIKit
import CoreLocation
import MapKit

fileprivate let typeImg = UIImage(named: "Riders")
fileprivate let typesData: [TypeCellVM] =
[
    TypeCellVM(type: "Велосипед", image: typeImg ?? UIImage()),
    TypeCellVM(type: "Бег", image: typeImg ?? UIImage()),
    TypeCellVM(type: "Ходьба", image: typeImg ?? UIImage())
]

class ActivityTrackingController: UIViewController {
    fileprivate let timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    fileprivate let timeFormatterShort: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    fileprivate let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var statesView: UIView!
    
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var startTitleLabel: UILabel!
    @IBOutlet weak var typeCollectionView: UICollectionView!
    @IBOutlet weak var startTrackingButton: PrimaryButton!
    
    @IBOutlet weak var finishView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var pauseButton: PauseButton!
    @IBOutlet weak var finishButton: FinishButton!
    
    private let CDHelper = CDController()
    
    private var activityDistance = CLLocationDistance()
    private var activityDate: Date?
    private var activityDuration = TimeInterval()
    private var selectedType: String?
    private var duration = TimeInterval()
    private var timerStart: Date?
    private var timer: Timer?
    
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
    
    private var previousRouteLine: MKPolyline?
    
    fileprivate var userLocationsHistory: [CLLocation] = [] {
        didSet {
            let coordinates = userLocationsHistory.map { $0.coordinate }
            
            if let previousRoute = previousRouteLine, !userLocationsHistory.isEmpty {
                mapView.removeOverlay(previousRoute as MKOverlay)
                previousRouteLine = nil
            }
            
            if userLocationsHistory.isEmpty {
                previousRouteLine = nil
            }
            
            let route = MKPolyline(coordinates: coordinates, count: coordinates.count)
            route.title = "Ваш маршрут"
            
            previousRouteLine = route
            
            mapView.addOverlay(route)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Новая активность"
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        typeCollectionView.dataSource = self
        typeCollectionView.delegate = self
        typeCollectionView.register(UINib(nibName: "TypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TypeCollectionViewCell")
        
        statesView.backgroundColor = .clear
        commonInit()
    }
    
    private func commonInit() {
        startView.layer.cornerRadius = 25
        startView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        startView.isHidden = false
        
        startTitleLabel.text = "Погнали? :)"
        
        startTrackingButton.setTitle("Старт", for: .normal)
        
        finishView.layer.cornerRadius = 25
        finishView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        typeLabel.text = "Активность"
        distanceLabel.text = "0.00 км"
        durationLabel.text = "00:00:00"
        finishView.isHidden = true
    }
    
    @objc private func updateTimer() {
        let currentTime = Date().timeIntervalSince(timerStart!)
        
        duration = currentTime
        durationLabel.text = timeFormatter.string(from: currentTime + activityDuration)
    }
    
    @IBAction func didTapStart(_ sender: PauseButton) {
        startView.isHidden = true
        finishView.isHidden = false
        
        activityDate = Date()
        timerStart = Date()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func didTapPause(_ sender: FinishButton) {
        userLocationsHistory = []
        userLocation = nil
        
        sender.isSelected.toggle()
        if sender.isSelected {
            self.timer?.invalidate()
            activityDuration += duration
            duration = TimeInterval()
            
            
            locationManager.stopUpdatingLocation()
        } else {
            timerStart = Date()
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func didTapFinish(_ sender: Any) {
        locationManager.stopUpdatingLocation()
        
        activityDuration += duration
        timer?.invalidate()
        
        let start = timeFormatterShort.string(from: activityDate!)
        let end = timeFormatterShort.string(from: activityDate! + activityDuration)
        
        let type = selectedType
        let date = dateFormatter.string(from: activityDate ?? Date())
        let distance = String(format: "%.2f км", activityDistance / 1000)
        let duration = timeFormatter.string(from: activityDuration)
        
        CDHelper.saveActivity(distance, duration!, type!, date, start, end)
        
        navigationController?.popViewController(animated: true)
    }
}

extension ActivityTrackingController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let curLocation = locations.first else {
            return
        }
        
        userLocation = curLocation
    }
}

extension ActivityTrackingController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let render = MKPolylineRenderer(polyline: polyline)
            
            render.fillColor = UIColor(red: 0.294, green: 0.035, blue: 0.953, alpha: 1)
            render.strokeColor = UIColor(red: 0.294, green: 0.035, blue: 0.953, alpha: 1)
            render.lineWidth = 5
            
            return render
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: "user_icon")
            
            let view = dequedView ?? MKAnnotationView(annotation: annotation, reuseIdentifier: "user_icon")
            
            view.image = UIImage(named: "MapPin")
            return view
        }
        return nil
    }
}

extension ActivityTrackingController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(typesData.count)
        return typesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = typesData[indexPath.row]
        
        let dequeuedCell = typeCollectionView.dequeueReusableCell(withReuseIdentifier: "TypeCollectionViewCell", for: indexPath)
        
        guard let upcastedCell = dequeuedCell as? TypeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        upcastedCell.bind(type)
        
        return upcastedCell
    }
}

extension ActivityTrackingController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as?
            TypeCollectionViewCell{
            cell.contentViewMy.layer.borderWidth = 2
            cell.contentViewMy.layer.borderColor = UIColor(red: 0.294, green: 0.035, blue: 0.953, alpha: 1).cgColor
            
            selectedType = cell.activityType
            typeLabel.text = selectedType
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TypeCollectionViewCell {
            cell.contentViewMy.layer.borderWidth = 0
        }
    }
}
