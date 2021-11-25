//
//  ActivitiesCellTableViewCell.swift
//  fefuactivity
//
//  Created by soFuckingHot on 23.11.2021.
//

import UIKit

struct ActivitiesTableViewModel {
    let distance: String
    let duration: String
    let activityTitle: String
    let timeAgo: String
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.selectionStyle = .none
        viewScreen.layer.cornerRadius = 10
        viewScreen.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind(_ type: ActivitiesTableViewModel) {
        timeLable.text = type.timeAgo
        activTitile.text = type.activityTitle
        imageActiv.image = type.icon
        durationLabel.text = type.duration
        distLabel.text = type.distance
    }
    
}
