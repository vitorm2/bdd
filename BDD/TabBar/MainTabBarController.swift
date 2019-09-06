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
    let listCoordinator = ConsultListCoordinator(presenter: UINavigationController())
    override func viewDidLoad() {
        super.viewDidLoad()
        appCoordinator.start()
        listCoordinator.start()
        //each view is a tab item
        viewControllers = [appCoordinator.rootViewController, listCoordinator.presenter]
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
