//
//  SignTextField.swift
//  fefuactivity
//
//  Created by Степан Хомулло on 28.10.2021.
//

import UIKit

class SignTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        SignTextFieldInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        SignTextFieldInit()
    }
    
    func SignTextFieldInit() {
        self.layer.cornerRadius = 6.62
        self.layer.borderWidth = 1.1
        self.layer.borderColor = UIColor(red: 0.58, green: 0.639, blue: 0.722, alpha: 1).cgColor
        
        //padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
    }
    
}
