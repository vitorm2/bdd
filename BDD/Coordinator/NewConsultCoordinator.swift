//
//  NewConsultCoordinator.swift
//  BDD
//
//  Created by Alexandre Scheer Bing on 02/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import Foundation

import UIKit

class NewConsultCoordinator: Coordinator {
    private var presenter: UINavigationController
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    func start() {
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main")
            as? ViewController
        presenter.setViewControllers([mainVC!], animated: true)
    }
}
