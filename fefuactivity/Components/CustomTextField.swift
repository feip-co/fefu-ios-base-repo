import UIKit

class CustomTextField: UITextField {
   
    override init(frame: CGRect) {
        super.init(frame: frame)

        initTextField()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initTextField()
    }

    private func initTextField() {}
}
