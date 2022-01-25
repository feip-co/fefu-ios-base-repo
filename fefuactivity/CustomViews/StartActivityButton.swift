//
//  StartActivityButton.swift
//  fefuactivity
//
//  Created by Егор Блинов on 18.10.2021.
//

import UIKit

class StartActivityButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyles()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyles()
    }
    
    private func setupStyles() {
        layer.cornerRadius = 10
        backgroundColor = .systemBlue
        setTitle("Старт", for: .normal)
    }
}
