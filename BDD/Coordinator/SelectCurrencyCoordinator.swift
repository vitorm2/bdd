//
//  SelectCoinCoordinator.swift
//  BDD
//
//  Created by Alexandre Scheer Bing on 03/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import Foundation
import UIKit

class SelectCurrencyCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    
    private var presenter: UINavigationController
    private var newConsultCoordinator: NewConsultCoordinator?
    private var selectCurrencyViewController: SelectCurrencyController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.childCoordinators = []
    }
    func start() {
        if let currencyVC = UIStoryboard(name: "SelectCurrency", bundle: nil)
            .instantiateViewController(withIdentifier: "SelectCurrency")
            as? SelectCurrencyController {
            
            currencyVC.delegate = self
            self.presenter.pushViewController(currencyVC, animated: true)
        }
    }
}

extension SelectCurrencyCoordinator: SelectCurrencyControllerDelegate {

    func startNewConsultViewController(_ controller: SelectCurrencyController, currencySelected: CurrencyCellViewData?) {

        let newConsultCoordinator = NewConsultCoordinator(presenter: presenter)
        self.newConsultCoordinator = newConsultCoordinator

        guard let currencySelected = currencySelected else { return }
        newConsultCoordinator.back(selectedCurrency: currencySelected) //Passa pro cordinator a moeda selecionada

    }
}

protocol SelectCurrencyControllerDelegate: class {
    func startNewConsultViewController(_ controller: SelectCurrencyController, currencySelected: CurrencyCellViewData?)
}
