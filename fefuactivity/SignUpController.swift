
import UIKit

class SignUpController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
   
    @IBOutlet weak var genderPicker: SignFEFUTextField!
    @IBOutlet weak var continueButton: ActivityFEFUButton!
    
    let genders = ["", "Мужской", "Женский"]
    
    let genderPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        
        genderPicker.inputView = genderPickerView
        
        commonInit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    private func commonInit() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        genderPicker.tintColor = .clear
        
        continueButton.setTitle("Продолжить", for: .normal)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Регистрация"
        navigationItem.prompt = ""
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
        genderPicker.text = genders[row]
        genderPicker.resignFirstResponder()
    }
}
