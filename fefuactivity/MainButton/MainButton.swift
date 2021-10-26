//
//  MainButton.swift
//  fefuactivity
//
//  Created by Степан Хомулло on 23.10.2021.
//

import UIKit

class MainButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 334, height: 56))
        self.backgroundColor = .white
        self.layer.backgroundColor = UIColor(red: 0.294, green: 0.035, blue: 0.953, alpha: 1).cgColor
        self.layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
