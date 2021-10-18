//
//  RegistrationController.swift
//  fefuactivity
//
//  Created by Mike Litvin on 07.10.2021.
//

import UIKit

class RegistrationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIBarButtonItem()
        navigationController?.navigationBar.topItem?.backBarButtonItem = button
        button.title = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationItem.title = "Регистрация"
    }
}
