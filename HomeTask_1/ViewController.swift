//
//  ViewController.swift
//  HomeTask_1
//
//  Created by wsr4 on 19.10.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        }

}


class ViewController1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
    }
    

}


class ViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}


class CustomTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 6.62
        layer.borderColor = UIColor(red: 0.58, green: 0.639, blue: 0.722, alpha: 1).cgColor
        layer.borderWidth = 1.1
        

    }
}




