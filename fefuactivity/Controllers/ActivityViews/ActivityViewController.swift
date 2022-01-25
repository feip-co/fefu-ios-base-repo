
import UIKit

// try to test so beautiful
struct ActivitiesTableViewModel {
    let date: String
    let activities: [ActivityTableViewCellViewModel]
}



class ActivityViewController: UIViewController {
    
    private let data: [ActivitiesTableViewModel] = {
        let yesterdayActivities: [ActivityTableViewCellViewModel] = [
            ActivityTableViewCellViewModel(distance: "14.32 км",
                                           duration: "2 часа 46 минут",
                                           activityTitle: "Велосипед",
                                           timeAgo: "14 часов назад",
                                           icon: UIImage(systemName: "bicycle.circle.fill") ?? UIImage(),
                                           startTime: "14:49",
                                           endTime: "16:31"
                                          )
        ]
        
        let mayActivities: [ActivityTableViewCellViewModel] = [
            ActivityTableViewCellViewModel(distance: "14.32 км",
                                           duration: "2 часа 46 минут",
                                           activityTitle: "Велосипед",
                                           timeAgo: "14 часов назад",
                                           icon: UIImage(systemName: "bicycle.circle.fill") ?? UIImage(),
                                           startTime: "14:49",
                                           endTime: "16:31"
                                          ),
            ActivityTableViewCellViewModel(distance: "2 км",
                                           duration: "15 минут",
                                           activityTitle: "Бег",
                                           timeAgo: "7 дней назад",
                                           icon: UIImage(systemName: "figure.walk.circle.fill") ?? UIImage(),
                                           startTime: "12:15",
                                           endTime: "12:30"
                                          )
        ]
        
        return [
            ActivitiesTableViewModel(date: "Вчера", activities: yesterdayActivities),
            ActivitiesTableViewModel(date: "Май 22 года", activities: mayActivities)
        ]
    }()
    
    
    @IBOutlet weak var startButton: ActivityFEFUButton!
    @IBOutlet weak var emptyStateTitle: UILabel!
    @IBOutlet weak var emptyStateDescription: UILabel!
    @IBOutlet weak var emptyStateView: UIView!
    
    @IBOutlet weak var listOfActivities: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    private func commonInit() {
        self.title = "Активности"
        
        startButton.setTitle("Старт", for: .normal)
        startButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        emptyStateTitle.text = "Время потренить"
        emptyStateDescription.text = "Нажимай на кнопку ниже и начинаем трекать активность"
        emptyStateView.backgroundColor = .clear
        
        listOfActivities.dataSource = self
        listOfActivities.delegate = self
        
        listOfActivities.register(UINib(nibName: "ActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "ActivityTableViewCell")
        
        listOfActivities.separatorStyle = .none
        listOfActivities.backgroundColor = .clear
        
        listOfActivities.isHidden = true
    }
    
    
    @IBAction func didExitEmptyState(_ sender: Any) {
        emptyStateView.isHidden = true
        listOfActivities.isHidden = false
    }
}



extension ActivityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailsView = ActivityDetailsViewController(nibName: "ActivityDetailsViewController", bundle: nil)

        detailsView.model = self.data[indexPath.section].activities[indexPath.row]
        
        navigationController?.pushViewController(detailsView, animated: true)
    }
}



extension ActivityViewController: UITableViewDataSource {
    
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
        
        let dequeuedCell = listOfActivities.dequeueReusableCell(withIdentifier: "ActivityTableViewCell", for: indexPath)
        
        guard let upcastedCell = dequeuedCell as? ActivityTableViewCell else {
            return UITableViewCell()
        }
        
        upcastedCell.bind(activityData)
        
        return upcastedCell
    }
    
    
}
