//
//  SignInController.swift
//  fefuactivity
//
//  Created by Егор Блинов on 07.10.2021.
//

import UIKit

class SignInController: UIViewController {
    
    @IBOutlet weak var continueButton: ActivityFEFUButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    private func commonInit() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.title = "Вход"
        navigationItem.prompt = ""
        
        continueButton.setTitle("Продолжить", for: .normal)
    }
}
