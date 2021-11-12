//
//  ActivityClass.swift
//  fefuactivity
//
//  Created by wsr5 on 12.11.2021.
//

import UIKit

class ActivityStartViewController: UIViewController {
    @IBAction func Swich(_ sender: Any) {
        FirstView.isHidden = false;
    }
    @IBOutlet weak var FirstView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        FirstView.isHidden = true;
    }

}

