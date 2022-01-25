import UIKit

struct ActivityViewModel {
    let distance: String
    let duration: String
    let activityType: String
    let startDate: String
    let icon: UIImage
    let startTime: String
    let endTime: String
}

class ActivityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var designContentView: UIView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var activityTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.selectionStyle = .none
        designContentView.layer.cornerRadius = 10
        designContentView.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind(_ model: ActivityViewModel) {
        distanceLabel.text = model.distance
        durationLabel.text = model.duration
        activityTitleLabel.text = model.activityType
        dateLabel.text = model.startDate
        iconView.image = model.icon
    }
    
    
}
