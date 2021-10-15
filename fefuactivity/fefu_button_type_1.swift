//
//  fefu_button_type_1.swift
//  fefuactivity
//
//  Created by иван on 15.10.2021.
//
import UIKit

class FEFUButtonType1: UIButton{
    required init?(coder: NSCoder){
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit(){
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor(named: "ButtonType1Color" )
    }
}

