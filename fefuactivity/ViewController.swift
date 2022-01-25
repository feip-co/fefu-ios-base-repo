//
//  ViewController.swift
//  fefuactivity
//
//  Created by Andrew L on 04.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: ActivityFEFUButton!
    
    
    @IBOutlet weak var alreadyExistButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.setTitle("Зарегистрироваться", for: .normal)
        alreadyExistButton.setTitle( "Уже есть аккаунт?", for: .normal)
        
        present(TabsViewController(nibName: "TabsViewController", bundle: nil), animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        signUpButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        alreadyExistButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
    }


    @IBAction func signUpButtonTap(_ sender: Any) {
        let signUpView = SignUpController(nibName: "SignUpController", bundle: nil)
        navigationController?.pushViewController(signUpView, animated: true)
    }
    
    @IBAction func alreadyExistButtonTap(_ sender: Any) {
        let signInView = SignInController(nibName: "SignInController", bundle: nil)
        navigationController?.pushViewController(signInView, animated: true)
    }
    
    
    
}

