import UIKit

class PauseButton: UIButton {
    
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
        
        self.backgroundColor = .systemBlue
        let pauseIcon = UIImage(named: "ic_pause")
        self.setImage(pauseIcon, for: .normal)
        
        self.isSelected = false
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.setImage(UIImage(named: "ic_resume"), for: .normal)
            } else {
                self.setImage(UIImage(named: "ic_pause"), for: .normal)
            }
        }
    }
}
