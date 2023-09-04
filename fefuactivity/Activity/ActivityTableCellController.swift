import UIKit

struct ActivityTableCellModel {
    let distance: String
    let duration: String
    let type: String
    let icon: UIImage
    let startDate: Date
    let endDate: Date
    let name: String

    func timeAgo() -> String {
        return startDate.timeAgo(Date())
    }
    func startTime() -> String {
        return startDate.clockDisplay()
    }
    func endTime() -> String {
        return endDate.clockDisplay()
    }
}

class ActivityTableCellController: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var typeIcon: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        cellView.layer.cornerRadius = 10
    }

    func bind(_ model: ActivityTableCellModel) {
        distanceLabel.text = model.distance
        nameLabel.text = model.name.count != 0 ? "@\(model.name)" : ""
        durationLabel.text = model.duration
        typeIcon.image = model.icon
        typeLabel.text = model.type
        timeAgoLabel.text = model.timeAgo()
    }
}
