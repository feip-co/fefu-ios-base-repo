import UIKit
import Foundation

struct ActivitiesTableViewModel {
    let distance: Double
    let duration: Double
    let activityTitle: String
    let timeAgo: Date
    let icon: UIImage
    let startTime: String
    let endTime: String
}


class ActivitiesCellTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var activTitile: UILabel!
    @IBOutlet weak var imageActiv: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var distLabel: UILabel!
    @IBOutlet weak var viewScreen: UIView!
    
    let timeFormatter = DateComponentsFormatter()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.selectionStyle = .none
        viewScreen.layer.cornerRadius = 10
        viewScreen.layer.masksToBounds = true
        
        timeFormatter.allowedUnits = [.hour, .minute, .second]
        timeFormatter.zeroFormattingBehavior = .pad
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind(_ model: ActivitiesTableViewModel) {
        let dst = String(format: "%.2f km", model.distance / 1000)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        distLabel.text = dst
        durationLabel.text = timeFormatter.string(from: model.duration)
        activTitile.text = model.activityTitle
        let curDate = Date()
        let interval = curDate.timeIntervalSince(model.timeAgo)
        timeLable.text = "\(Int(round(interval / 3600) )) hours ago"
        imageActiv.image = model.icon
    }
    
}
