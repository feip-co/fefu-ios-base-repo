//
//  MainScrViewController.swift
//  fefuactivity
//
//  Created by soFuckingHot on 11.10.2021.
//

import UIKit

class MainScrViewController: UIViewController {
    
    
    @IBOutlet weak var RegBtn: CStyledButton!
    @IBOutlet weak var ExistBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(navigationController)
        ExistBtn.setTitle("Уже есть аккаунт?", for: .normal)
        RegBtn.setTitle("Зарегистрироваться", for: .normal)
    }
    
    @IBAction func RegBtnTap(_ sender: Any) {
        let regView = RegisterController(nibName: "RegisterController", bundle: nil)
        
        navigationController?.pushViewController(regView, animated: true)
    }
    
    @IBAction func LogBtnTap(_ sender: Any) {
        let logView = LoginController(nibName: "LoginController", bundle: nil)
        
        navigationController?.pushViewController(logView, animated: true)
    }
    
    


}
