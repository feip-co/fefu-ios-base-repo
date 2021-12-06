import Foundation
import UIKit

class FinishActivityBtn: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        selfInit()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        selfInit()
    }
    
    private func selfInit() {
        self.setTitle("", for: .normal)
        self.layer.cornerRadius = self.bounds.size.width * 0.5
        self.backgroundColor = UIColor(named: "BlueBtnColor")
        self.setImage(UIImage(named: "i_finish"), for: .normal)
    }
}
