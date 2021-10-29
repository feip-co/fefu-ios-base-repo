//
//  custom_navigation_item_type1.swift
//  fefuactivity
//
//  Created by иван on 16.10.2021.
//
import UIKit
class CustomNavigationBar: UINavigationBar {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        CommonInit()
    }
    private func CommonInit(){
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}
