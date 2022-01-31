import UIKit

struct ActivityTableViewVM {
    let date: String
    let activities: [ActivityTableCellVM]
}

class ActivityListController: UIViewController {
    @IBOutlet weak var startActivityButton: PrimaryButton!
    @IBOutlet weak var emptyDataView: UIView!
    @IBOutlet weak var activityList: UITableView!
    private let CDHelper = CDController()
    
    private var data: [ActivityTableViewVM] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityList.delegate = self
        activityList.dataSource = self
        
        let cellNib = UINib(nibName: "ActivityTableViewCell", bundle: nil)
        activityList.register(cellNib, forCellReuseIdentifier: "ActivityTableViewCell")
        
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch()
        self.activityList.reloadData()
    }
    
    private func commonInit() {
        self.title = "Активности"
        
        self.startActivityButton.setTitle("Старт", for: .normal)
        
        emptyDataView.backgroundColor = .clear
        
        activityList.backgroundColor = .clear
        activityList.separatorStyle = .none
        
        emptyDataView.isHidden = data.isEmpty
        activityList.isHidden = !data.isEmpty
    }
    
    private func fetch() {
        do {
            let rawActivities = try CDHelper.fetch()
            let activitiesViewModels: [ActivityTableCellVM] = rawActivities.map { activity in
                let image = UIImage(systemName: "bicycle.circle.fill") ?? UIImage()
                
                return ActivityTableCellVM(distance: activity.distance ?? "",
                                         duration: activity.duration ?? "",
                                         title: activity.type ?? "",
                                         timeAgo: activity.date ?? "",
                                         icon: image,
                                         start: activity.start ?? "",
                                         end: activity.end ?? "")
            }
            
            let group = Dictionary(grouping: activitiesViewModels) { activityVM in
                return activityVM.timeAgo
            }
            
            self.data = group.map { (key, values) in
                return ActivityTableViewVM(date: key, activities: values)
            }
        } catch {
            print(error)
        }
        
    }
    
    @IBAction func didStartActivity(_ sender: Any) {
        let VC = ActivityTrackingController(nibName: "ActivityTrackingController", bundle: nil)
        self.navigationController?.pushViewController(VC, animated: true)
    }
}

extension ActivityListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let VC = ActivityDetailsController(nibName: "ActivityDetailsController", bundle: nil)
        VC.bind(self.data[indexPath.section].activities[indexPath.row])
        
        self.navigationController?.pushViewController(VC, animated: true)
    }
}

extension ActivityListController: UITableViewDataSource {
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
        
        let dequeuedCell = activityList.dequeueReusableCell(withIdentifier: "ActivityTableViewCell", for: indexPath)
        
        guard let upcastedCell = dequeuedCell as? ActivityTableViewCell else {
            return UITableViewCell()
        }
        
        upcastedCell.bind(activityData)
        
        return upcastedCell
    }
}
