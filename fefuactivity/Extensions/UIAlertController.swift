import Foundation
import UIKit

extension UIAlertController {
    static func createErrorAlert(_ errorMessage: String, _ btnTitle: String) -> UIAlertController {
        let alert = UIAlertController(title: "Ошибка", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: btnTitle, style: .cancel, handler: nil))

        return alert
    }
}
