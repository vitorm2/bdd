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
    private var presenter: UINavigationController
    private var selectCurrencyViewController: SelectCurrencyController?
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        if let currencyVC = UIStoryboard(name: "SelectCurrency", bundle: nil)
            .instantiateViewController(withIdentifier: "SelectCurrency")
            as? SelectCurrencyController {
            self.selectCurrencyViewController = currencyVC
            self.presenter.pushViewController(currencyVC, animated: true)
        }
    }
}
