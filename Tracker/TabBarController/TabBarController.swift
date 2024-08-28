//
//  TabBarControllerViewController.swift
//  Tracker
//
//  Created by Дмитрий Жуков on 8/7/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
    }
    
    private func generateTabBar() {
        let navigationViewController = UINavigationController(rootViewController: TrackerViewController())
//        tabBar.layer.borderWidth = 1
//        tabBar.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        tabBar.tintColor = .tabBarAccentIcon
        tabBar.unselectedItemTintColor = .unselectedTabBarIcon
        viewControllers = [
            generateVC(viewController: navigationViewController,
                       title: "Трекеры", 
                       image: UIImage(named: "trackerIcon")
                      ),
            generateVC(viewController: StatisticViewController(),
                       title: "Статистика",
                       image: UIImage(named: "statisticIcon")
                      )
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .medium)]
               viewController.tabBarItem.setTitleTextAttributes(attributes, for: .normal)
               viewController.tabBarItem.setTitleTextAttributes(attributes, for: .selected)
        
        return viewController
    }

}
