import UIKit

class ActivityDetailsController: UIViewController {
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var startEndLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeAgoLabel2: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var activityStartButton: PrimaryButton!
    
    private var data: ActivityTableCellVM? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: nil, action: nil)
    }
    
    func bind(_ model: ActivityTableCellVM) {
        self.data = model
    }
    
    private func commonInit() {
        activityStartButton.setTitle("Старт", for: .normal)
        
        distanceLabel.text = data?.distance
        timeAgoLabel.text = data?.timeAgo
        durationLabel.text = data?.duration
        startEndLabel.text = "Старт: \(data?.start ?? "нет данных") • Финиш: \(data?.end ?? "нет данных")"
        titleLabel.text = data?.title
        timeAgoLabel2.text = data?.timeAgo
        iconView.image = data?.icon
        
        self.title = data?.title
    }
}
