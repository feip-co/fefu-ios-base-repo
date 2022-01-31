import UIKit

class RegistrationController: UIViewController {
    private let encoder = JSONEncoder()
    
    @IBOutlet weak var loginField: FormTextField!
    @IBOutlet weak var nameField: FormTextField!
    @IBOutlet weak var passwordField: FormTextField!
    @IBOutlet weak var passwordConfirmationField: FormTextField!
    @IBOutlet weak var selectGender: UITextField!
    @IBOutlet weak var continueButton: PrimaryButton!
    
    private let selectGenderView = UIPickerView()
    private var gender = 0
    
    private let gendersList = ["Женский", "Мужской"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectGenderView.dataSource = self
        selectGenderView.delegate = self
        
        commonInit()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.continueButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
    }
    
    private func commonInit() {
        let back = UIBarButtonItem()
        back.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = back
        
        self.title = "Регистрация"
        
        continueButton.setTitle("Продолжить", for: .normal)
        
        selectGender.layer.sublayerTransform = CATransform3DMakeTranslation(-10, 0, 0)
        selectGender.inputView = selectGenderView
    }
    
    @IBAction func didTapContinue(_ sender: Any) {
        let login = loginField.text ?? ""
        let password = passwordField.text ?? ""
        let passwordConfirm = passwordConfirmationField.text ?? ""
        let name = nameField.text ?? ""
        let gender = gender
        
        if passwordConfirm != password {
            let alert = UIAlertController(title: "Ошибобчка", message: "Пароли дазнт мэтчинг", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        let body = RegisterBody(login: login, password: password, name: name, gender: gender)
        
        do {
            let reqBody = try AuthService.encoder.encode(body)
            let queue = DispatchQueue.global(qos: .utility)
            AuthService.register(reqBody) { user in
                queue.async {
                    UserDefaults.standard.set(user.token, forKey: "token")
                }
                DispatchQueue.main.async {
                    let VC = TabsController(nibName: "TabsController", bundle: nil)
                    VC.modalPresentationStyle = .fullScreen
                    self.present(VC, animated: true, completion: nil)
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

extension RegistrationController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        gender = row
        selectGender.text = gendersList[row]
        selectGender.resignFirstResponder()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gendersList[row]
    }
}

extension RegistrationController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gendersList.count
    }
}

extension RegistrationController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegistrationController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
