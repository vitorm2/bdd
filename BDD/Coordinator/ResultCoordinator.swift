//
//  ResultCoordinator.swift
//  BDD
//
//  Created by Vitor Demenighi on 05/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//
// swiftlint:disable all

import Foundation
import UIKit

class ResultCoordinator: Coordinator {
    private var presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    
    func start(){}
    
    
    func startResult(result: ConvertResultViewData) {
        if let currencyVC = UIStoryboard(name: "Result", bundle: nil).instantiateViewController(withIdentifier: "Result")
            as? ResultController {
            
            currencyVC.result = result // Passa o resultado pra proxima tela
            self.presenter.pushViewController(currencyVC, animated: true)
            
        }
    }
}

