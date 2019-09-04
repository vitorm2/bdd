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
    private var selectCurrencyCoordinator: SelectCurrencyCoordinator?
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    func start() {
        if let mainVC = UIStoryboard(name: "NewConsult", bundle: nil).instantiateViewController(withIdentifier: "NewConsult")
            as? NewConsultViewController {
            mainVC.delegate = self
            presenter.setViewControllers([mainVC], animated: true)
        }
    }
}

extension NewConsultCoordinator: NewConsultViewControllerDelegate {
    func newConsultViewController(_ controller: NewConsultViewController) {
        let selectCurrencyCoordinator = SelectCurrencyCoordinator(presenter: presenter)
        self.selectCurrencyCoordinator = selectCurrencyCoordinator
        selectCurrencyCoordinator.start()
    }
}

protocol NewConsultViewControllerDelegate: class {
    func newConsultViewController(_ controller: NewConsultViewController/*, didSelect movie: Movie*/)
}
