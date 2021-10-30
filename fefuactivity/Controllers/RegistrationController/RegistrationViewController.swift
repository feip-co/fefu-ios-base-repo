//
//  RegistrationViewController.swift
//  fefuactivity
//
//  Created by Степан Хомулло on 22.10.2021.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var genderTextField: PopUpTextField!
    
    let gender = ["Мужской", "Женский"]
    
    let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Регистрация"
        
        pickerView.delegate = self
        pickerView.dataSource = self
        self.genderTextField.inputView = pickerView
    }
}

extension RegistrationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = gender[row]
        genderTextField.resignFirstResponder()
    }
}
