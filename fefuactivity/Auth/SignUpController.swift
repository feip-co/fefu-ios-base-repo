import UIKit

class SignUpController: UIViewController {

    @IBOutlet weak var Login: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var PasswordCheck: UITextField!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Gender: GenderPickerTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func Eye1(_ sender: UIButton) {
        if Password.isSecureTextEntry == true {
            Password.isSecureTextEntry = false
        }
        else {
            Password.isSecureTextEntry = true
        }
    }
    
    @IBAction func Eye2(_ sender: Any) {
        if PasswordCheck.isSecureTextEntry == true {
            PasswordCheck.isSecureTextEntry = false
        }
        else {
            PasswordCheck.isSecureTextEntry = true
        }
    }
    
    @IBAction func RegistrButton(_ sender: UIButton) {
        let login = Login.text ?? ""
        let name = Name.text ?? ""
        let password = Password.text ?? ""
        let passwordConfirm = PasswordCheck.text ?? ""
        let gender = Gender.code

        if password != passwordConfirm {
            return
        }
        let data = RegisterRequestModel(login: login, password: password, name: name, gender: gender)

        do {
            let reqBody = try API.encoder.encode(data)
            Sign.register(reqBody) { user in
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
