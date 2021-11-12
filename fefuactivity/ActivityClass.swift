//
//  ActivityClass.swift
//  fefuactivity
//
//  Created by wsr5 on 12.11.2021.
//

import UIKit

class ActivityStartViewController:
    UIViewController {
    @IBAction func Swich(_ sender: Any) {
        FirstView.isHidden = true;
        AlmostWorkingTableView.isHidden = false;
    }
    let idCell = "CellFinal"
    let time = ["Вчера","Май 2022 года"]
    @IBOutlet weak var AlmostWorkingTableView: UITableView!
    @IBOutlet weak var FirstView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        AlmostWorkingTableView.isHidden = true;
        AlmostWorkingTableView.dataSource = self;
        AlmostWorkingTableView.delegate = self;
        AlmostWorkingTableView.register(UINib(nibName: "CellFinal", bundle:nil), forCellReuseIdentifier: idCell)
        self.AlmostWorkingTableView.rowHeight = 220
    }

}

extension ActivityStartViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellFinal", for: indexPath) as! CellFinal
        cell.title.text = time[indexPath.row]
        return cell
    }
    
    
}
