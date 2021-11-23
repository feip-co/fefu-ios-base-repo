//
//  CTextField.swift
//  fefuactivity
//
//  Created by soFuckingHot on 11.11.2021.
//

import UIKit

class CTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        selfInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        selfInit()
    }
    
    private func selfInit() {
        backgroundColor = .white
        layer.cornerRadius = 6.62
        layer.borderWidth = 1.1
        layer.borderColor = UIColor(named: "TextFieldBorderColor")?.cgColor
        
        let placeholderT = placeholder ?? ""
        let placeholderC = UIColor(named: "PlaceholderColor")
        attributedPlaceholder = NSAttributedString(string: placeholderT, attributes: [NSAttributedString.Key.foregroundColor : placeholderC ?? UIColor.lightGray])
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 17, height: frame.height))
        
        leftView = leftPaddingView
        leftViewMode = .always
        
        
    }
}
