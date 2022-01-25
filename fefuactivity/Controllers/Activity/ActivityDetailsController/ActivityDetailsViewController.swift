import UIKit

class ActivityDetailsViewController: UIViewController {
    var model: ActivityViewModel?
    
    @IBOutlet weak var startButton: ActivityFEFUButton!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var activityDurationLabel: UILabel!
    @IBOutlet weak var startEndTimeLabel: UILabel!
    @IBOutlet weak var activityTitleLabel: UILabel!
    
    // тут однозначно нужен фикс, странный UI
    @IBOutlet weak var secondTimeAgoLabel: UILabel!
    @IBOutlet weak var iconActivity: UIImageView!
    @IBOutlet weak var commentField: SignFEFUTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.setTitle("Старт", for: .normal)
        startButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bind(model!)
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: nil, action: nil)
    }
    
    func bind(_ model: ActivityViewModel) {
        distanceLabel.text = model.distance
        
        activityDurationLabel.text = model.duration
        
        startEndTimeLabel.text = "Cтарт: \(model.startTime) Финиш: \(model.endTime)"
        
        activityTitleLabel.text = model.activityType
        self.title = model.activityType
        
        dateLabel.text = model.startDate
        secondTimeAgoLabel.text = model.startDate
        iconActivity.image = model.icon
    }
    
    @IBAction func didStartTracking(_ sender: Any) {
        let startActivityController = StartActivityViewController(nibName: "StartActivityViewController", bundle: nil)
        
        navigationController?.pushViewController(startActivityController, animated: true)
    }
}
