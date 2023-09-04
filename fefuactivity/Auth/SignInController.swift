
import UIKit

class SignInController: UIViewController {

    @IBOutlet weak var Login: UITextField!
    @IBOutlet weak var Password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func Eye(_ sender: UIButton) {
        if Password.isSecureTextEntry == true {
            Password.isSecureTextEntry = false
        }
        else {
            Password.isSecureTextEntry = true
        }
    }
    @IBAction func AuthButton(_ sender: UIButton) {
        let login = Login.text ?? ""
        let password = Password.text ?? ""

        let loginData = LoginRequestModel(login: login, password: password)

        do {
            let data = try API.encoder.encode(loginData)
            Sign.login(data) { auth in
                DispatchQueue.main.async {
                    UserDefaults.standard.set(auth.token, forKey: "token")
 
                    let vc = UIStoryboard(name: "End", bundle: nil).instantiateInitialViewController()
                    vc?.modalPresentationStyle = .fullScreen
                    self.present(vc!, animated: true, completion: nil)
                }
            } reject: { error in
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
}
