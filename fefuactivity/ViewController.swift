//
//  ViewController.swift
//  fefuactivity
//
//  Created by Andrew L on 04.10.2021.
//

import UIKit

class ViewController:  UIViewController {
    
    @IBOutlet weak var passField: UITextField!
    
    @IBOutlet weak var genderField: UITextField!
    
    @IBOutlet weak var repeatPass: UITextField!
    let genders = ["Man", "Woman"]
    
    let pickerView = UIPickerView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //pickerView.delegate = self
        //pickerView.dataSource = self
        
        //genderField.inputView = pickerView
        //genderField.textAlignment = .center
        //genderField.placeholder = "Пол"
    }
    
    
    @IBAction func hidePass(_ sender: UIButton)
    {
        if passField.isSecureTextEntry == false
        {
            passField.isSecureTextEntry = true
        }
        else
        {
            passField.isSecureTextEntry = false
            
        }
    }
    
    @IBAction func hideRepeatPass(_ sender: UIButton)
    {
        if repeatPass.isSecureTextEntry == false
        {
            repeatPass.isSecureTextEntry = true
        }
        else
        {
            repeatPass.isSecureTextEntry = false
            
        }
    }

    

}
