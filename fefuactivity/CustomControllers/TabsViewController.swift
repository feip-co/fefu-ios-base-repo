//
//  TabsViewController.swift
//  fefuactivity
//
//  Created by soFuckingHot on 23.11.2021.
//

import UIKit

class TabsViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("debug print")
        let activityNavController = UINavigationController(rootViewController: ActivitiesViewController())
        let profileNavController = UINavigationController(rootViewController: ProfileViewController())
        
        activityNavController.tabBarItem.title = "Activity"
        profileNavController.tabBarItem.title = "Profile"
        
        activityNavController.tabBarItem.image = UIImage(systemName: "circle")
        profileNavController.tabBarItem.image = UIImage(systemName: "circle")
        
        self.setViewControllers([activityNavController, profileNavController], animated: true)
        
        modalPresentationStyle = .overFullScreen
        
    }


}
