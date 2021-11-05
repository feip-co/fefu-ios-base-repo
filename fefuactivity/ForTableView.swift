//
//  ForTableView.swift
//  fefuactivity
//
//  Created by wsr4 on 05.11.2021.
//

import UIKit

class NovaTestController:UIViewController{
    
    let idCell = "test"
    @IBOutlet weak var NewTable: UITableView!
    let mytext = ["вчера", "22 октября"]
    override func viewDidLoad() {
        super.viewDidLoad()
        NewTable.dataSource = self
    }
    
}

extension NovaTestController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: idCell)
        cell.textLabel?.text = "sdfsdf"
        return cell
    }
    
    
}
