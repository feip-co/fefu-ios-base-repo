
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
}

class CustomTextField : UITextField{
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 6.62
        layer.borderColor = UIColor(red: 0.58, green: 0.639, blue: 0.722, alpha: 1).cgColor
        layer.borderWidth = 1.1
    }
}



