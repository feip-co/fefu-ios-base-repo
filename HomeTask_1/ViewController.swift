//
//  ViewController.swift
//  HomeTask_1
//
//  Created by wsr4 on 19.10.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        }

}


class ViewController1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
    }
    

}


class ViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}


class CustomTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 6.62
        layer.borderColor = UIColor(red: 0.58, green: 0.639, blue: 0.722, alpha: 1).cgColor
        layer.borderWidth = 1.1
        

    }
}


class ViewController_task2: UIViewController {
    
    @IBOutlet weak var foreground: UIView!
    @IBOutlet weak var labelFirst: UILabel!
    @IBOutlet weak var labelSecond: UILabel!
    @IBAction func startButton(_ sender: Any) {
        foreground.isHidden = true
        labelFirst.isHidden = true
        labelSecond.isHidden = true
    }
    
    let idCell = "myCell"
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: idCell)
    }
}

extension ViewController_task2: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as! TableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Вчера"
        }
        else {
            return "Май 2022 года"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Routine")
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
    }
    
}

class ExactActivity: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
    }
    
}







