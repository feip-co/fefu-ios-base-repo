import Foundation
import UIKit

class CStyledButton : UIButton {
    private func setStyles() {
        layer.cornerRadius = 12
        backgroundColor = UIColor(named: "BlueBtnColor")
        setTitleColor(.white, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
        }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setStyles()
    }
}

