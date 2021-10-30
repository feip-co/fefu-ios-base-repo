
import UIKit


class MyTableViewController : ViewController, UITableViewDataSource, UITableViewDelegate {
    
    let ceilId = "MyCeilId"
    
    
    @IBAction func startButtonClick(_ sender: Any) {
        mainTableView.isHidden = false
        headerLabel.isHidden = true
    }
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var mainTableView: UITableView!
    
    let headerLabel: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
    }()
    

    
    
    func makeDefaulView(){
        

        
        
        headerLabel.frame = CGRect(x: 0, y: 0, width: 290.5, height: 80)
        headerLabel.backgroundColor = UIColor.white
        headerLabel.text = "Время потренить\nНажимай на кнопку ниже и начинаем трекать активность"
        headerLabel.textAlignment = .center
        
        headerLabel.font = UIFont.systemFont(ofSize: 17)
        
        
        headerLabel.textColor = UIColor.black
        headerLabel.widthAnchor.constraint(equalToConstant: 290.5).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 80.49).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.25).isActive = true
        headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 360.73).isActive = true
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "Вчера"
        }
        else{
            return "Май 2022 года"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ceil = tableView.dequeueReusableCell(withIdentifier: ceilId)	as! TableViewCell
        return ceil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "info") as! TableInfoViewController
        
                navigationController?.pushViewController(vc,
                                                         animated: true)
    }
    @IBOutlet weak var newTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        newTableView.dataSource = self
        newTableView.register(UINib(nibName:"TableViewCell", bundle: nil), forCellReuseIdentifier: ceilId)
        mainTableView.isHidden = true
        
        view.addSubview(headerLabel)
        makeDefaulView()
    }
    
}

class TableInfoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
	
