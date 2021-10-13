//
//  fefuButtonType1.swift
//  fefuactivity
//
//  Created by иван on 07.10.2021.
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
        self.frame.size = CGSize(width: 334.0, height: 56.0);
        
    }
}
