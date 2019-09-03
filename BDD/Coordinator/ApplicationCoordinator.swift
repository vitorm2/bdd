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
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private var newConsultCoordinator: NewConsultCoordinator?
    init(window: UIWindow) {
        self.window = window
        //Setting navigation controller
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationBar.barTintColor = #colorLiteral(red: 0.07058823529, green: 0.07843137255, blue: 0.1294117647, alpha: 1)
        rootViewController.navigationBar.isTranslucent = false
        rootViewController.navigationBar.shadowImage = UIImage()
        rootViewController.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor(cgColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))]
        newConsultCoordinator = NewConsultCoordinator(presenter: rootViewController)
    }
    func start() {
        window.rootViewController = rootViewController
        newConsultCoordinator?.start()
        window.makeKeyAndVisible()
    }
}
