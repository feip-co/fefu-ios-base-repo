import UIKit
import CoreLocation

struct ActivitiesTableModel {
    let date: Date
    let activities: [ActivityTableCellModel]
}

class ActivityController: UIViewController {

    private var selectedSection: Int = Int()
    private var selectedRow: Int = Int()
    private var tableData: [ActivitiesTableModel] = []

    @IBOutlet var segmentContainerView: UIView!
    @IBOutlet var segmentControlView: UISegmentedControl!
    @IBOutlet var activityTableView: UITableView!
    @IBOutlet var emptyStateView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        emptyStateView.isHidden = false
        activityTableView.isHidden = true

        activityTableView.dataSource = self
        activityTableView.delegate = self
        
        segmentContainerView.layer.borderColor = UIColor.systemGray4.cgColor
        segmentContainerView.layer.borderWidth = 1

        fetch()
    }

    private func fetch(_ segmentIndex: Int = 0) {
        if segmentIndex == 0 {
            fetchUserActivities()
        } else {
            fetchSocialActivities()
        }
    }

    private func fetchUserActivities() {
        let context = FEFUCoreDataContainer.instance.context
        let request = CDActivity.fetchRequest()

        do {
            let rawActivities = try context.fetch(request)
            let activities: [ActivityTableCellModel] = rawActivities.map { activity in
                let image = UIImage(systemName: "bicycle.circle.fill") ?? UIImage()
                return ActivityTableCellModel(distance: activity.distance,
                                              duration: activity.duration,
                                              type: activity.type,
                                              icon: image,
                                              startDate: activity.startDate,
                                              endDate: activity.endDate,
                                              name: "")
            }
            let sortedActivities = activities.sorted { $0.startDate > $1.startDate }
            let grouppedActivities = Dictionary(grouping: sortedActivities, by: { $0.startDate.callendarDate() }).sorted(by: {
                $0.key > $1.key
            })
            tableData = grouppedActivities.map { (date, activities) in
                return ActivitiesTableModel(date: date, activities: activities)
            }
            
            reloadTable()
        } catch {
            print(error)
        }
    }

    private func fetchSocialActivities() {
        Activities.activities { rawActivities in
            DispatchQueue.main.async {
                let activities: [ActivityTableCellModel] = rawActivities.items.map { activity in
                    let image = UIImage(systemName: "bicycle.circle.fill") ?? UIImage()
                    var prevLocation: CLLocation? = nil
                    var distance: Double = 0
                    activity.geoTrack.forEach({ location in
                        let location = CLLocation(latitude: location.lat, longitude: location.lon)
                        
                        if prevLocation != nil {
                            distance += location.distance(from: prevLocation!) / 1000
                        }
                        prevLocation = location
                    })

                    return ActivityTableCellModel(distance: String(format: "%.2f", distance) + " км",
                                                  duration: activity.startsAt.interval(activity.endsAt),
                                                  type: activity.activityType.name,
                                                  icon: image,
                                                  startDate: activity.startsAt,
                                                  endDate: activity.endsAt,
                                                  name: activity.user.name)
                }
                let sortedActivities = activities.sorted { $0.startDate > $1.startDate }
                let grouppedActivities = Dictionary(grouping: sortedActivities, by: { $0.startDate.callendarDate() }).sorted(by: {
                    $0.key > $1.key
                })
                
                self.tableData = grouppedActivities.map { (date, activities) in
                    return ActivitiesTableModel(date: date, activities: activities)
                }
                
                self.reloadTable()
            }
        } reject: { error in
            print(error!)
            DispatchQueue.main.async {
                self.tableData = []
                self.reloadTable()
            }
        }
    }

    private func reloadTable() {
        DispatchQueue.main.async {
            self.activityTableView.reloadData()
            self.activityTableView.isHidden = self.tableData.isEmpty
            self.emptyStateView.isHidden = !self.tableData.isEmpty
        }
    }
    
    @IBAction func startActivityHandler(_ sender: Any) {
        performSegue(withIdentifier: "StartActivity", sender: self)
    }
    
    @IBAction func segmentControlChangeHandler(_ sender: Any) {
        fetch(segmentControlView.selectedSegmentIndex)
    }
}

extension ActivityController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UITextView()
        header.textContainerInset = UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 0)
        header.font = .boldSystemFont(ofSize: 20)
        header.text = tableData[section].date.callendarDisplay()
        header.backgroundColor = .clear
        return header
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].activities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let activityData = self.tableData[indexPath.section].activities[indexPath.row]
        
        let reusableCell = activityTableView.dequeueReusableCell(withIdentifier: "ActivityTableCell", for: indexPath)
        
        guard let cell = reusableCell as? ActivityTableCellController else {
            return UITableViewCell()
        }

        cell.bind(activityData)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        self.selectedSection = indexPath.section
        self.selectedRow = indexPath.row
        performSegue(withIdentifier: "ActivityDetails", sender: nil)
    }
}

extension ActivityController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ActivityDetails":
            let destination = segue.destination as! ActivityDetailsController
            destination.model = self.tableData[self.selectedSection].activities[self.selectedRow]
        case "StartActivity":
            let destination = segue.destination as! StartActivityController
            destination.delegate = self
        default:
            break
        }
    }
}

extension ActivityController: ActivityRouteDelegate {
    func activityDidCreate() {
        fetch()
    }
}
