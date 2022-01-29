import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    @IBAction func signUp(_ sender: UIButton) {
        let signUp = SignUpController(nibName: "SignUpController", bundle: nil)
        navigationController?.pushViewController(signUp, animated: true)
    }
    
    
    @IBAction func signIn(_ sender: UIButton) {
        let signIn = SignInController(nibName: "SignInController", bundle: nil)
        navigationController?.pushViewController(signIn, animated: true)
    }
    
}

