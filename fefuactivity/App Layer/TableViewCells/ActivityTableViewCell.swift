import UIKit

struct ActivityTableCellVM {
    let distance: String
    let duration: String
    let title: String
    let timeAgo: String
    let icon: UIImage
    let start: String
    let end: String
}

class ActivityTableViewCell: UITableViewCell {
    @IBOutlet weak var customContentView: UIView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var timeAgoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        customContentView.layer.cornerRadius = 10
        customContentView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind(_ model: ActivityTableCellVM) {
        distanceLabel.text = model.distance
        durationLabel.text = model.duration
        titleLabel.text = model.title
        iconView.image = model.icon
        timeAgoLabel.text = model.timeAgo
    }
    
}
