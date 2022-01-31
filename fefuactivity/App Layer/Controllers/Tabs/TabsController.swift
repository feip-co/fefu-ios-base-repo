import UIKit

class TabsController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTabs()
    }
    
    private func initTabs() {
        let activitiesNav = UINavigationController(rootViewController: ActivityListController())
        let profileNav = UINavigationController(rootViewController: ProfileController())
        
        activitiesNav.tabBarItem.title = "Активности"
        activitiesNav.tabBarItem.image = UIImage(systemName: "circle")
        
        profileNav.tabBarItem.title = "Профиль"
        profileNav.tabBarItem.image = UIImage(systemName: "circle")
        
        self.setViewControllers([activitiesNav, profileNav], animated: true)
        
        modalPresentationStyle = .overFullScreen
    }
}
