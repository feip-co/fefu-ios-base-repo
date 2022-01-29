import UIKit

class AuthorizationController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: SecureTextField!

    @IBAction func loginHandler(_ sender: Any) {
        let login = loginField.text ?? ""
        let password = passwordField.text ?? ""

        let loginData = LoginRequestModel(login: login, password: password)

        do {
            let data = try API.encoder.encode(loginData)
            API.login(data) { auth in
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
