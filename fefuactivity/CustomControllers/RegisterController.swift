//
//  RegisterController.swift
//  fefuactivity
//
//  Created by soFuckingHot on 11.11.2021.
//

import UIKit

class RegisterController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var ContinueBtn: CStyledButton!
    @IBOutlet weak var ScrollViewOutlet: UIScrollView!
    @IBOutlet weak var genderPickerOutlet: CTextField!
    
    
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
    
    let genders = ["", "Мужской", "Женский"]
    
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
