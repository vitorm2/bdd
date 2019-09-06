//
//  ConsultListCoordinator.swift
//  BDD
//
//  Created by Alexandre Scheer Bing on 05/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import UIKit

class FeedCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var presenter: UINavigationController
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.childCoordinators = []
        presenter.navigationBar.prefersLargeTitles = true
        presenter.navigationBar.barTintColor = #colorLiteral(red: 0.07058823529, green: 0.07843137255, blue: 0.1294117647, alpha: 1)
        presenter.navigationBar.isTranslucent = false
        presenter.navigationBar.shadowImage = UIImage()
        presenter.navigationBar.tintColor = UIColor.white
        presenter.navigationBar.barStyle = .black
        presenter.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor(cgColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))]
    }
    func start() {
        if let mainVC = UIStoryboard(name: "Feed", bundle: nil).instantiateViewController(withIdentifier: "Feed") as? FeedViewController{
            mainVC.tabBarItem = UITabBarItem.init(title: " ", image: UIImage.init(named: "Feed1"), tag: 0)
            //mainVC.tabBarItem.image = UIImage.init(named: "portfolio")
            mainVC.tabBarItem.selectedImage = UIImage.init(named: "Feed")
            presenter.setViewControllers([mainVC], animated: true)
        }
    }
}
