import UIKit

class PauseToggleButton: UIButton {
    
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
        let pauseIcon = UIImage(named: "PauseIcon")
        self.setImage(pauseIcon, for: .normal)
        self.isSelected = false
    }
    
    override var isSelected: Bool {
        didSet {
            self.isHighlighted = false
            if isSelected {
                self.setImage(UIImage(named: "ResumeIcon"), for: .normal)
            } else {
                self.setImage(UIImage(named: "PauseIcon"), for: .normal)
            }
        }
    }
}
