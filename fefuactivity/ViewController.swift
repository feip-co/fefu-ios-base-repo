import UIKit

class ViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func regButtonTap(_ sender: Any) {
        let controller = RegistrationController(nibName:"RegistrationController", bundle: nil);
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
