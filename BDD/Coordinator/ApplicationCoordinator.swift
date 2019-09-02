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
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        newConsultCoordinator = NewConsultCoordinator(presenter: rootViewController)
    }
    func start() {
        window.rootViewController = rootViewController
        newConsultCoordinator?.start()
        window.makeKeyAndVisible()
    }
}
