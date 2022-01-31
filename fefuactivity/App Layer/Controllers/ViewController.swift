import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var registerButton: PrimaryButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        registerButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
    }
    
    func commonInit() {
        registerButton.setTitle("Зарегистрироваться", for: .normal)
        loginButton.setTitle( "Уже есть аккаунт?", for: .normal)
    }
    
    
    @IBAction func didTapRegister(_ sender: Any) {
        let VC = RegistrationController(nibName: "RegistrationController", bundle: nil)
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        let VC = LoginController(nibName: "LoginController", bundle: nil)
        self.navigationController?.pushViewController(VC, animated: true)
    }
}

