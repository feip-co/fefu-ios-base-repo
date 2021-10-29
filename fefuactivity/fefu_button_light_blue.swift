//
//  fefu_button_light_blue.swift
//  fefuactivity
//
//  Created by иван on 27.10.2021.
//

import UIKit

class FEFUButtonType2LightBlue: UIButton{
    required init?(coder: NSCoder){
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit(){
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor.systemBlue;
    }
}

