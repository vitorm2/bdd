//
//  ApplicationCoordinator.swift
//  BDD
//
//  Created by Alexandre Scheer Bing on 02/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    //private let window: UIWindow
    let rootViewController: UINavigationController
    private var newConsultCoordinator: NewConsultCoordinator?
    init(rootViewController: UINavigationController) {
        //self.window = window
        //Setting navigation controller
        self.rootViewController = rootViewController
        rootViewController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationBar.barTintColor = #colorLiteral(red: 0.07058823529, green: 0.07843137255, blue: 0.1294117647, alpha: 1)
        rootViewController.navigationBar.isTranslucent = false
        rootViewController.navigationBar.shadowImage = UIImage()
        rootViewController.navigationBar.tintColor = UIColor.white
        rootViewController.navigationBar.barStyle = .black
        rootViewController.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor(cgColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))]
        newConsultCoordinator = NewConsultCoordinator(presenter: rootViewController)
    }
    func start() {
        newConsultCoordinator?.start()
    }
}
