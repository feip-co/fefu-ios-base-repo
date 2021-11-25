//
//  ActivityDetailsViewController.swift
//  fefuactivity
//
//  Created by soFuckingHot on 24.11.2021.
//

import UIKit

class ActivityDetailsViewController: UIViewController {

    
    @IBOutlet weak var distance: UILabel!
    
    
    @IBOutlet weak var timeAgo: UILabel!
    @IBOutlet weak var actionImage: UIImageView!
    @IBOutlet weak var startEnd: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var timeAgo2: UILabel!
    
    
    @IBOutlet weak var activityName: UILabel!
    var model: ActivityTableViewCellViewModel? = nil
    
    private func selfInit() {
        
        distance.text = model?.distance
        timeAgo.text = model?.timeAgo
        startEnd.text = "Старт: \(model?.startTime ?? "нет данных") • Финиш: \(model?.endTime ?? "нет данных")"
        duration.text = model?.duration
        activityName.text = model?.activityTitle
        timeAgo2.text = model?.timeAgo
        actionImage.image = model?.icon
        
        self.title = model?.activityTitle
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //selfInit()
        // Do any additional setup after loading the view.
    }
    
    //override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(animated)
        /*navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: nil, action: nil)
         */ 
   // }

}
