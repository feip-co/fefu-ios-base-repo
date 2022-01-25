import UIKit

class FinishActivityButton: UIButton {
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
        self.backgroundColor = UIColor(named: "ButtonBackgroundColor")
        let finishIcon = UIImage(named: "FinishIcon")
        self.setImage(finishIcon, for: .normal)
    }
}
