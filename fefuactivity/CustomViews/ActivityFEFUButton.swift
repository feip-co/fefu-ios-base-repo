//
//  ActivityFEFUButton.swift
//  fefuactivity
//
//  Created by Егор Блинов on 04.10.2021.
//

import UIKit

class ActivityFEFUButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyles()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyles()
    }
    
    private func setupStyles() {
        layer.cornerRadius = 12
        backgroundColor = UIColor(named: "ButtonBackgroundColor")
        setTitleColor(.white, for: .normal)
    }
}
