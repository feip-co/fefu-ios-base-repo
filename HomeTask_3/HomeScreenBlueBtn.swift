//
//  HomeScreenBlueBtn.swift
//  fefuactivity
//
//  Created by soFuckingHot on 28.10.2021.
//

import Foundation
import UIKit

class CHomeScreenBlueBtn : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyles()
        }
        
    private func setupStyles() {
        layer.cornerRadius = 12
        setTitleColor(.white, for: .normal)
    }
    
}

