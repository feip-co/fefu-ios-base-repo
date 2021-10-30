//
//  ActivitiesController.swift
//  fefuactivity
//
//  Created by Mike Litvin on 28.10.2021.
//

import UIKit

class ActivitiesController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .overFullScreen
    }
}
