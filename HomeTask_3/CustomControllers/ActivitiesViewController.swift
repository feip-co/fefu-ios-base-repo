import UIKit
import CoreData

struct ActivitiesViewModel {
    let date: Date
    let activities: [ActivitiesTableViewModel]
}


class ActivitiesViewController: UIViewController {
    
    private var data: [ActivitiesViewModel] = [ActivitiesViewModel]()

    @IBOutlet weak var emptyActivitiesScreen: UIView!
    @IBOutlet weak var activitiesTable: UITableView!
    @IBOutlet weak var emptyActivitiesDesc: UILabel!
    @IBOutlet weak var emptyActivitiesTitile: UILabel!
    @IBOutlet weak var startBtn: CStyledButton!
    
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfInit()
        fetchFromCoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFromCoreData()
        self.activitiesTable.reloadData()
    }
    
    private func createDateComponents(_ activityDate: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: activityDate)
        return calendar.date(from: components) ?? Date()
    }
    
    private func fetchFromCoreData() {
        let context = FEFUCoreDataContainer.instance.context
        
        let fetching = NewEntity.fetchRequest()
        
        do {
            let raw = try context.fetch(fetching)
            let activityModels: [ActivitiesTableViewModel] = raw.map {
                activity in
                let img = UIImage(systemName: "bicycle.circle.fill") ?? UIImage()
                return ActivitiesTableViewModel(distance: activity.distance, duration: activity.time, activityTitle: activity.activity ?? "", timeAgo: activity.date ?? Date(), icon: img, startTime: activity.start ?? "", endTime: activity.end ?? "")
            }
            
            let groupByDate = Dictionary(grouping: activityModels) {
                activ in return createDateComponents(activ.timeAgo)
            }
            
            self.data = groupByDate.map {(key, value) in
                return ActivitiesViewModel(date: key, activities: value)
            }
            
        } catch {
                
            }
            
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
        activitiesTable.isHidden = !self.data.isEmpty
        
        emptyActivitiesScreen.isHidden = self.data.isEmpty
        
        dateFormatter.dateStyle = .medium
        
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
        
        
        
        let date = data[section].date
        let optHeader = dateFormatter.string(from: date)
        header.text = optHeader
        
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let activityData = self.data[indexPath.section].activities[indexPath.row]
        
        let dequeuedCell = activitiesTable.dequeueReusableCell(withIdentifier: "ActivitiesCellTableViewCell", for: indexPath)
        
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

        let activity = self.data[indexPath.section].activities[indexPath.row]
        detailsView.model = activity
        
        navigationController?.pushViewController(detailsView, animated: true)
    }
    
}
