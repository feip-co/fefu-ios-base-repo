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
        self.layer.cornerRadius = 10
        self.backgroundColor = .systemBlue
        self.titleLabel?.textColor = .white
        self.setTitle("Старт", for: .normal)
    }
}
