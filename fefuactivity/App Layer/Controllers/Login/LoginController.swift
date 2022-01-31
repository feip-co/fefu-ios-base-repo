import UIKit

class LoginController: UIViewController {
    private let encoder = JSONEncoder()
    
    @IBOutlet weak var loginField: FormTextField!
    @IBOutlet weak var passwordField: FormTextField!
    @IBOutlet weak var continueButton: PrimaryButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.continueButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
    }
    
    private func commonInit() {
        let back = UIBarButtonItem()
        back.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = back
        
        self.title = "Войти"
        
        continueButton.setTitle("Продолжить", for: .normal)
    }
    
    @IBAction func didTapContinue(_ sender: Any) {
        let login = loginField.text ?? ""
        let password = passwordField.text ?? ""
        
        let body = LoginBody(login: login, password: password)
        
        do {
            let reqBody = try encoder.encode(body)
            let queue = DispatchQueue.global(qos: .utility)
            AuthService.login(reqBody) { user in
                DispatchQueue.main.async {
                    let VC = TabsController(nibName: "TabsController", bundle: nil)
                    VC.modalPresentationStyle = .fullScreen
                    self.present(VC, animated: true, completion: nil)
                }
                queue.async {
                    UserDefaults.standard.set(user.token, forKey: "token")
                }
            } onError: { err in
                DispatchQueue.main.async {
                    self.sendAlert(err: err.errors)
                }
            }
        } catch {
            print(error)
        }
    }
    
    private func sendAlert(err: Dictionary<String, [String]>) {
        var alertText = ""
        for (_, values) in err {
            for e in values {
                alertText += e + "\n"
            }
        }
        
        let alert = UIAlertController(title: "Чек филдз", message: alertText, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ладно", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
