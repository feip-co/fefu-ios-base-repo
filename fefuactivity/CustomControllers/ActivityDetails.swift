//
//  ActivityDetails.swift
//  fefuactivity
//
//  Created by soFuckingHot on 25.11.2021.
//

import UIKit

class ActivityDetails: UIViewController {
    @IBOutlet weak var comment: CTextField!
    
    @IBOutlet weak var timeLeft: UILabel!
    @IBOutlet weak var activityImg: UIImageView!
    @IBOutlet weak var startEnd: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var timeAgo: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var activityTitle: UILabel!
    
    var model: ActivitiesTableViewModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        distance.text = model?.distance
        timeLeft.text = model?.timeAgo
        activityImg.image = model?.icon
        startEnd.text = "Старт: \(model?.startTime ?? "нет данных") • Финиш: \(model?.endTime ?? "нет данных")"
        duration.text = model?.duration
        timeAgo.text = model?.timeAgo
        activityTitle.text = model?.activityTitle
        
        self.title = model?.activityTitle
        
    }
    
    
    

}
