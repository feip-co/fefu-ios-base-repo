import UIKit

class RegistrationController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: SecureTextField!
    @IBOutlet weak var passwordConfirmField: SecureTextField!
    @IBOutlet weak var genderField: GenderPickerTextField!

    @IBAction func registerHandler(_ sender: Any) {
        let login = loginField.text ?? ""
        let name = nameField.text ?? ""
        let password = passwordField.text ?? ""
        let passwordConfirm = passwordConfirmField.text ?? ""
        let gender = genderField.code

        if password != passwordConfirm {
            return
        }
        let data = RegisterRequestModel(login: login, password: password, name: name, gender: gender)

        do {
            let reqBody = try API.encoder.encode(data)
            API.register(reqBody) { user in
                DispatchQueue.main.async {
                    UserDefaults.standard.set(user.token, forKey: "token")

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
