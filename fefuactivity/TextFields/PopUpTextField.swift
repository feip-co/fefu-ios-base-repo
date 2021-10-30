//
//  PopUpTextField.swift
//  fefuactivity
//
//  Created by Степан Хомулло on 30.10.2021.
//

import UIKit

class PopUpTextField: SignTextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        PopUpTextFieldInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        PopUpTextFieldInit()
    }

    func PopUpTextFieldInit() {
        let genderButton = UIButton(type: .custom)
        genderButton.setImage(UIImage(named: "Choose"), for: .normal)
        genderButton.contentEdgeInsets = UIEdgeInsets(top: 13, left: 0, bottom: 13, right: 18)
        self.rightView = genderButton
        self.rightViewMode = .always
    }
}
