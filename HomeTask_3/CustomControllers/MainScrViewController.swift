import UIKit

class MainScrViewController: UIViewController {
    
    
    @IBOutlet weak var RegBtn: CStyledButton!
    @IBOutlet weak var ExistBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ExistBtn.setTitle("Уже есть аккаунт?", for: .normal)
        RegBtn.setTitle("Зарегистрироваться", for: .normal)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
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
