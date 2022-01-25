//
//  TabsViewController.swift
//  fefuactivity
//
//  Created by Егор Блинов on 19.10.2021.
//

import UIKit

class TabsViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
    }

    private func createTabBar() {
        
        let activityNavigationController = UINavigationController(rootViewController: ActivityViewController())
        let profileNavigationController = UINavigationController(rootViewController: ProfileViewController())
        
        activityNavigationController.tabBarItem.title = "Активности"
        activityNavigationController.tabBarItem.image = UIImage(systemName: "circle")
        
        profileNavigationController.tabBarItem.title = "Профиль"
        profileNavigationController.tabBarItem.image = UIImage(systemName: "circle")
        
        self.setViewControllers([activityNavigationController, profileNavigationController], animated: true)
        
        modalPresentationStyle = .overFullScreen
    }
}
