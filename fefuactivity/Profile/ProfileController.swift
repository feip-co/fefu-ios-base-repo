import UIKit

class ProfileController: UITableViewController {

    private var user: UserModel? {
        didSet {
            nameLabel?.text = user?.name
            loginLabel?.text = user?.login
            genderLabel?.text = user?.gender.name
        }
    }

    @IBOutlet var profileTable: UITableView! {
        didSet {
            profileTable.delegate = self
        }
    }
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        Client.profile { user in
            DispatchQueue.main.async {
                self.user = user
            }
        } reject: { err in
            print(err)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func logoutHandler(_ sender: Any) {
        Sign.logout {
            DispatchQueue.main.async {
                UserDefaults.standard.removeObject(forKey: "token")
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                vc?.modalPresentationStyle = .fullScreen
                self.present(vc!, animated: true, completion: nil)
            }
        } reject: { error in
            print(error)
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if (cell.restorationIdentifier == "ChangePassword") {
                performSegue(withIdentifier: "ChangePassword", sender: self)
            }
        }
    }
}
