//
//  ActivitiesViewController.swift
//  fefuactivity
//
//  Created by soFuckingHot on 20.11.2021.
//

import UIKit

struct ActivitiesViewModel {
    let date: String
    let activities: [ActivitiesTableViewModel]
}



class ActivitiesViewController: UIViewController {
    
    // zaglushka
    private let data: [ActivitiesViewModel] = {
        let yesterdayActivities: [ActivitiesTableViewModel] = [
            ActivitiesTableViewModel(distance: "14.32 км",
                                           duration: "2 часа 46 минут",
                                           activityTitle: "Велосипед",
                                           timeAgo: "14 часов назад",
                                           icon: UIImage(systemName: "bicycle.circle.fill") ?? UIImage(),
                                           startTime: "14:49",
                                           endTime: "16:31"
                                          )
        ]
        
        let mayActivities: [ActivitiesTableViewModel] = [
            ActivitiesTableViewModel(distance: "14.32 км",
                                           duration: "2 часа 46 минут",
                                           activityTitle: "Велосипед",
                                           timeAgo: "14 часов назад",
                                           icon: UIImage(systemName: "bicycle.circle.fill") ?? UIImage(),
                                           startTime: "14:49",
                                           endTime: "16:31"
                                          ),
        ]
        
        return [
            ActivitiesViewModel(date: "Вчера", activities: yesterdayActivities),
            ActivitiesViewModel(date: "Май 22 года", activities: mayActivities)
        ]
    }()

    @IBOutlet weak var emptyActivitiesScreen: UIView!
    @IBOutlet weak var activitiesTable: UITableView!
    @IBOutlet weak var emptyActivitiesDesc: UILabel!
    @IBOutlet weak var emptyActivitiesTitile: UILabel!
    @IBOutlet weak var startBtn: CStyledButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfInit()
        // Do any additional setup after loading the view.
    }
    
    private func selfInit() {
        self.title = "Активности"
        
        startBtn.setTitle("Старт", for: .normal)
        startBtn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        emptyActivitiesTitile.text = "Время потренить"
        emptyActivitiesDesc.text = "Нажимай на кнопку ниже и начинаем трекать активность"
        emptyActivitiesScreen.backgroundColor = .clear
        
        activitiesTable.dataSource  = self
        activitiesTable.delegate = self
        
        activitiesTable.register(UINib(nibName: "ActivitiesCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ActivitiesCellTableViewCell")
        
        activitiesTable.separatorStyle = .none
        activitiesTable.backgroundColor = .clear
        activitiesTable.isHidden = true
    }
    
    
    
    @IBAction func didStartBtnTap(_ sender: Any) {
        let activityController = ActivityBeginViewController(nibName: "ActivityBeginViewController", bundle: nil)
        
        navigationController?.pushViewController(activityController, animated: true)
        
    }
    

}


extension ActivitiesViewController: 	UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UILabel()
        header.font = .boldSystemFont(ofSize: 20)
        header.text = data[section].date
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let activityData = self.data[indexPath.section].activities[indexPath.row]
        
        let dequeuedCell = activitiesTable.dequeueReusableCell(withIdentifier: "ActivitiesCellTableViewCell", for: indexPath)
        
        // not work without guard asks unwrap
        guard let upcastedCell = dequeuedCell as? ActivitiesCellTableViewCell
        else {
            return UITableViewCell()
        }
        
        upcastedCell.bind(activityData)
        
        return upcastedCell
    }
    
}

extension ActivitiesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailsView = ActivityDetails(nibName: "ActivityDetails", bundle: nil)

        detailsView.model = self.data[indexPath.section].activities[indexPath.row]
        
        navigationController?.pushViewController(detailsView, animated: true)
    }
    
}
