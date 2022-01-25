import UIKit

class ActivityDetailsViewController: UIViewController {
    
    var model: ActivityTableViewCellViewModel? = nil
    
    @IBOutlet weak var startButton: ActivityFEFUButton!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
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
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: nil, action: nil)
    }
    
    private func commonInit() {
        distanceLabel.text = model?.distance
        timeAgoLabel.text = model?.timeAgo
        activityDurationLabel.text = model?.duration
        startEndTimeLabel.text = "Старт: \(model?.startTime ?? "нет данных") • Финиш: \(model?.endTime ?? "нет данных")"
        activityTitleLabel.text = model?.activityTitle
        secondTimeAgoLabel.text = model?.timeAgo
        iconActivity.image = model?.icon
        
        self.title = model?.activityTitle
    }
}
