//
//  fefu_custom_label1.swift
//  fefuactivity
//
//  Created by иван on 15.10.2021.
//

import UIKit

class Fefu_custom_label: UILabel{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    private func commonInit(){
        self.font = UIFont(name: "Roboto", size: self.font.pointSize)
    }
}
