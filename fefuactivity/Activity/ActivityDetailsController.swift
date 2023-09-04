import UIKit

class ActivityDetailsController: UIViewController {
    
    var model: ActivityTableCellModel!

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeAgoLabel1: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var startStopTime: UILabel!
    @IBOutlet weak var typeIcon: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var timeAgoLabel2: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = model.type
        
        distanceLabel.text = model.distance
        durationLabel.text = model.duration
        timeAgoLabel1.text = model.timeAgo()
        timeAgoLabel2.text = model.timeAgo()
        startStopTime.text =  "Старт: \(model.startTime()) • Финиш: \(model.endTime())"
        typeLabel.text = model.type
        typeIcon.image = model.icon
        usernameLabel.text = model.name.count > 0 ? "@\(model.name)" : ""
    }
}
