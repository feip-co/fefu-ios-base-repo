import UIKit
import CoreLocation
import MapKit
import CoreData


private let activitiesTypeData: [ActivityTypeCellModel] =
[
    ActivityTypeCellModel(nameOfType: "Bycicle", imageType: UIImage(named: "i_lilBackground") ?? UIImage(), manageStateTitle: "On bycicle"),
    ActivityTypeCellModel(nameOfType: "Run", imageType: UIImage(named: "i_lilBackground") ?? UIImage(), manageStateTitle: "Run")
]


class ActivityBeginViewController: UIViewController {

    private let coreContainer = FEFUCoreDataContainer.instance

    @IBOutlet weak var createScreen: TopCornersView!
    @IBOutlet weak var createTitle: UILabel!
    @IBOutlet weak var listActivitiesType: UICollectionView!
    @IBOutlet weak var startBtn: CStyledButton!
    
    @IBOutlet weak var manageScreen: TopCornersView!
    @IBOutlet weak var finishBtn: UIButton!
    @IBOutlet weak var pauseBtn: CStyledButton!
    @IBOutlet weak var typeActivity: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var commonView: UIView!
    
    private var spendTimeInActivity: TimeInterval = TimeInterval()
    private var spendTimeAtAll: TimeInterval = TimeInterval()
    private var pickedActivityType: String?
    private let userLocationIdentifier = "user_icon"
    
    @IBOutlet weak var mapView: MKMapView!
    private var m_activityType: String?
    
    private var startActivityDate: Date?
    private var activityDistance: CLLocationDistance = CLLocationDistance()
    
    let dataFormatter = DateFormatter()
    private var timer: Timer?
    private var startTimerTime: Date?
    private var spendTimeAtAllInActivity: TimeInterval = TimeInterval()
    
    
    @objc private func timerHandler() {
        let timeSince = Date().timeIntervalSince(startTimerTime!)
        
        spendTimeInActivity = timeSince
        let Timeformatter = DateComponentsFormatter()
        Timeformatter.allowedUnits = [.hour, .minute, .second];
        Timeformatter.zeroFormattingBehavior = .pad;
        
        timeLabel.text = Timeformatter.string(from: timeSince + spendTimeAtAllInActivity)
        
        print(spendTimeInActivity)
    }
    
    private var prevSegment: MKPolyline?
    
    private let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        return manager
    }()
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("888NPOOOOOOO")
        m_activityType = "none"
    }
    
    
    @IBAction func didTapPauseActivity(_ sender: PRActivityBtn) {
        userLocation = nil
        userLocationsHistory = []
        
        sender.isSelected.toggle()
        if sender.isSelected {
            spendTimeAtAllInActivity += spendTimeInActivity
            spendTimeInActivity = 0
            timer?.invalidate()
            
            locationManager.stopUpdatingLocation()
        } else {
            startTimerTime = Date()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerHandler), userInfo: nil, repeats: true)
            
            locationManager.startUpdatingLocation()
        }
    }
    
    
    @IBAction func didTapBeginActivity(_ sender: Any) {
    
        self.navigationItem.setHidesBackButton(true, animated: true)
        createScreen.isHidden = true
        manageScreen.isHidden = false
        
        startActivityDate = Date()
        startTimerTime = Date()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerHandler), userInfo: nil, repeats: true)
        
        locationManager.startUpdatingLocation()
    }
    
    
    @IBAction func didTapFinishActivity(_ sender: Any) {
        locationManager.stopUpdatingLocation()
        
        let context = coreContainer.context
        let activity = NewEntity(context: context)
        
        spendTimeAtAllInActivity += spendTimeInActivity
        timer?.invalidate()
        
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "HH:mm"
        let startTime = dataFormatter.string(from: startActivityDate!)
        let endTime = dataFormatter.string(from: startActivityDate! + spendTimeAtAllInActivity)
        
        activity.date = startActivityDate
        activity.start = startTime
        activity.end = endTime
        activity.time = spendTimeAtAllInActivity
        activity.activity = m_activityType
        activity.distance = activityDistance
        
        coreContainer.saveContext()        
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonView.backgroundColor = .clear
        
        self.title = "Новая активность"
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        mapView.delegate = self
        mapView.tag = 1
        mapView.showsUserLocation = true
    
        listActivitiesType.register(
            UINib(nibName: "ActivityTypeCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier:
                String(describing: ActivityTypeCollectionViewCell.self
            )
        )
        
        listActivitiesType.delegate = self
        listActivitiesType.dataSource = self
        
        
        m_activityType = "none"
        startBtn.isEnabled = false
        initCreateActivityScr()
        initManageActivityScr()
    }

    private func initCreateActivityScr() {
        createScreen.isHidden = false
        
        createTitle.text = "Погнали? :)"
        startBtn.setTitle("Старт", for: .normal)
    }

    private func initManageActivityScr() {
        manageScreen.isHidden = true
        
        typeActivity.text = "Activity"
        distance.text = "0.00 km"
        timeLabel.text = "00:00:00"
    }
   fileprivate var userLocation: CLLocation? {
        didSet {
            if let userLocation = userLocation {
                let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                
                if oldValue != nil {
                    activityDistance += userLocation.distance(from: oldValue!)
                }
                
                distance.text = String(format: "%.2f km", activityDistance / 1000)
                mapView.setRegion(region, animated: true)
                
                userLocationsHistory.append(userLocation)
            }
        }
    }
    
    
    fileprivate var userLocationsHistory: [CLLocation] = [] {
        didSet {
            let coordinates = userLocationsHistory.map { $0.coordinate }
            
            
            if let prevRoute = prevSegment, !userLocationsHistory.isEmpty{
                mapView.removeOverlay(prevRoute as MKOverlay)
                prevSegment = nil
            }
            
            if userLocationsHistory.isEmpty {
                prevSegment = nil
            }
            
            let route = MKPolyline(coordinates: coordinates, count: coordinates.count)
            route.title = "Ваш маршрут"
            
            prevSegment = route
            
            mapView.addOverlay(route)
        }
    }
    
}

extension ActivityBeginViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
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


extension ActivityBeginViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ActivityTypeCollectionViewCell {
            cell.cardView.layer.borderColor = UIColor(named: "BlueBtnColor")?.cgColor
            
            cell.cardView.layer.borderWidth = 2
            m_activityType = cell.gTypeName
            pickedActivityType = cell.gTypeName
            startBtn.isEnabled = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ActivityTypeCollectionViewCell {
            cell.cardView.layer.borderWidth = 0
        }
    }
}


extension ActivityBeginViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  activitiesTypeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentActivity = activitiesTypeData[indexPath.row]
        
        if let deqCell = listActivitiesType.dequeueReusableCell(withReuseIdentifier: "ActivityTypeCollectionViewCell", for: indexPath) as? ActivityTypeCollectionViewCell {
            deqCell.bind(currentActivity)
            return deqCell
        } else {
            return UICollectionViewCell()
        }
    }
}


