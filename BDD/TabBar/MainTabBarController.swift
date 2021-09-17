//
//  MainTabBarController.swift
//  BDD
//
//  Created by Alexandre Scheer Bing on 05/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    let appCoordinator = ApplicationCoordinator(rootViewController: UINavigationController())
    let listCoordinator = FeedCoordinator(presenter: UINavigationController())
    let portfolioCoordinator = PortfolioCoordinator(presenter: UINavigationController())
    override func viewDidLoad() {
        super.viewDidLoad()
        appCoordinator.start()
        listCoordinator.start()
        portfolioCoordinator.start()
        //each view is a tab item
//        tabBar.backgroundColor = UIColor(red: 0.07, green: 0.08, blue: 0.13, alpha: 1)
        tabBar.barTintColor = UIColor(red: 0, green: 0, blue: 0.063, alpha: 1)
        viewControllers = [listCoordinator.presenter, appCoordinator.rootViewController, portfolioCoordinator.presenter]
        tabBar.layer.shadowOffset = CGSize.init(width: 0, height: -4)
        tabBar.layer.shadowRadius = 14
        tabBar.layer.shadowColor = UIColor.init(red: 0.65, green: 0.45, blue: 1.0, alpha: 1.0).cgColor
        tabBar.layer.shadowOpacity = 0.1
        self.selectedIndex = 1
        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
