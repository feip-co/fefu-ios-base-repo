import UIKit

class FinishButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.setTitle("", for: .normal)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.backgroundColor = .blue
        
        let finishIcon = UIImage(named: "ic_finish")
        self.setImage(finishIcon, for: .normal)
    }
}
