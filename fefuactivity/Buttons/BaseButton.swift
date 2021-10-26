//
//  BaseButton.swift
//  fefuactivity
//
//  Created by Степан Хомулло on 23.10.2021.
//

import UIKit

class BaseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 12
        setTitleColor(.white, for: .normal)
        layer.backgroundColor = UIColor(red: 0.294, green: 0.035,
                                             blue: 0.953, alpha: 1).cgColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        layer.cornerRadius = 12
        setTitleColor(.white, for: .normal)
        layer.backgroundColor = UIColor(red: 0.294, green: 0.035,
                                             blue: 0.953, alpha: 1).cgColor
    }
}
