//
//  LoginController.swift
//  fefuactivity
//
//  Created by Mike Litvin on 15.10.2021.
//

import UIKit

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIBarButtonItem()
        navigationController?.navigationBar.topItem?.backBarButtonItem = button
        button.title = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationItem.title = "Вход"
    }

}
