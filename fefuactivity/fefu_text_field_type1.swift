//
//  fefu_text_field_type1.swift
//  fefuactivity
//
//  Created by иван on 16.10.2021.
//

import UIKit

class Fefu_text_field_type_1: UITextField{
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        CommonInit()
    }
    private func CommonInit(){
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: "text_field_color_type_1")?.cgColor
        backgroundColor = .clear
    }
}
