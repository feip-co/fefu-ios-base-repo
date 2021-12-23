import UIKit

class RegisterController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource {


    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var genderPickerOutlet: CTextField!

    @IBOutlet weak var ContinueBtn: CStyledButton!
    @IBOutlet weak var ScrollViewOutlet: UIScrollView!

    private var genderNumber = 0


    @IBAction func didRegisterBtnTap(_ sender: Any) {
        let login = loginField.text ?? ""
        let password = passwordField.text ?? ""
        let repeatPassword = repeatPasswordField.text ?? ""
        let nickname = nicknameField.text ?? ""

        if (login == "" || password == "" || repeatPassword == ""
            || nickname == "") {
            let alert = UIAlertController(title: "Wrong data", message: "Fields cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)

            return
        }

        if password != repeatPassword {
            let alert = UIAlertController(title: "Passwords are not the same.",
                                          message: "Please try again!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try again", style: .cancel, handler: clearPasswFileds))
            self.present(alert, animated: true, completion: nil)

            return
        }

        let preRequest = UserRegBody(login: login, password: password, name: nickname, gender: genderNumber)

        do {
            let request = try UserAuthRegistrUrl.encoder.encode(preRequest)
            UserAuthRegistrUrl.reg(request) { user in
                print(user.token)
                UserAuthRegistr.instance.saveUser(login: login, password: password, key: user.token)
                DispatchQueue.main.async {
                    let view = TabsViewController(nibName: "TabsViewController", bundle: nil)
                    view.modalPresentationStyle = .fullScreen
                    self.present(view, animated: true, completion: nil)
                }

            }

        } catch _ {

        }
    }


    private func clearPasswFileds(alert: UIAlertAction!) {
        passwordField.text = ""
        repeatPasswordField.text = ""
    }


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderPickerOutlet.text = genders[row]
        genderPickerOutlet.resignFirstResponder()
        genderNumber = row
    }
    private func selfInit() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        genderPickerOutlet.tintColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        SetUpNotify()
        
    }
    
    func SetUpNotify() {
        let notification = NotificationCenter.default
        
        notification.addObserver(self, selector: #selector(willShowKeyboard(_: )), name:UIWindow.keyboardWillShowNotification, object: nil)
        
        notification.addObserver(self, selector: #selector(willHideKeyboard(_:)), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    @objc func willShowKeyboard(_ sender: Notification) {
        let rawFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        guard let height = rawFrame?.cgRectValue.height else {
            return
        }
        
        ScrollViewOutlet.contentInset.bottom = height
    }
    
    @objc func willHideKeyboard(_ sender: Notification) {
        ScrollViewOutlet.contentInset.bottom = 0
    }

    let genders = ["Мужской", "Женский"]

    let genderPicker = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genderPicker.delegate = self
        genderPicker.dataSource = self
        genderPickerOutlet.inputView = genderPicker
        
        selfInit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
}
