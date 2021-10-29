//
//  ViewController.swift
//  fefuactivity
//
//  Created by Andrew L on 04.10.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var MyTable: UITableView!
    let mytext = ["вчера", "22 октября"]
    override func viewDidLoad() {
        super.viewDidLoad()
        MyTable.delegate = self
        MyTable.dataSource = self
    }

    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mytext.count
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyTable.dequeueReusableCell(withIdentifier: "test") as! MySecondCell
        cell.KmLable.text = "4 км"
        cell.HowLongAgoLable.text = "24 часа назад"
        cell.HowLongLable.text = "2 часа 30 минут"
        cell.TitleLable.text = mytext[indexPath.row]
        cell.ImageLable.image = UIImage(named: "bicucle")
        cell.TypeLable.text = "велосипед"
        return cell
    }
    
    
}
