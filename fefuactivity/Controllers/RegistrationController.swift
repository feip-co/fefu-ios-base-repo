//
//  RegistrationController.swift
//  fefuactivity
//
//  Created by Mike Litvin on 07.10.2021.
//

import UIKit

class RegistrationController: UIViewController {
    
    @IBOutlet weak var genderField: registrationTextField!
    
    let genders = ["", "Мужчина", "Женщина"]
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIBarButtonItem()
        navigationController?.navigationBar.topItem?.backBarButtonItem = button
        button.title = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationItem.title = "Регистрация"
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        genderField.inputView = pickerView
        
    }
}

extension RegistrationController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        genderField.text = genders[row]
        genderField.resignFirstResponder()
    }
}
