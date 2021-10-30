//
//  PasswordTextField.swift
//  fefuactivity
//
//  Created by Степан Хомулло on 29.10.2021.
//

import UIKit

class PasswordTextField: SignTextField {
    let button = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        PasswordTextFieldInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        PasswordTextFieldInit()
    }
    
    func PasswordTextFieldInit() {
        self.isSecureTextEntry = true
        
        button.setImage(UIImage(named: "Eye"), for: .normal)
        button.setImage(UIImage(named: "BlindEye"), for: .selected)
        button.contentEdgeInsets = UIEdgeInsets(top: 13, left: 0, bottom: 13, right: 18)
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
    }
    
    @objc func togglePasswordView(_ sender: Any) {
            isSecureTextEntry.toggle()
            button.isSelected.toggle()
    }
    
}
