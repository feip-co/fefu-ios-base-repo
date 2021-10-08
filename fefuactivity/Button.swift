//
//  Button.swift
//  fefuactivity
//
//  Created by wsr4 on 08.10.2021.
//

import UIKit

class ButtonType1: UIButton{
    required init?(coder: NSCoder){
        super.init(coder:coder)
        
        commonInit()
        
    }
    
    private func commonInit(){
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor(named: "ButtonColorBlueBack")
        
    }
    
}
