//
//  registrationTextField.swift
//  fefuactivity
//
//  Created by Mike Litvin on 18.10.2021.
//

import UIKit

class registrationTextField: UITextField {
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            fieldInit()
        }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        fieldInit()
    }
    
    private func fieldInit(){
        layer.cornerRadius = 6
        layer.borderWidth = 0.5
        layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
        }
    
}

