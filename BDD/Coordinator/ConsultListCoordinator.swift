//
//  ConsultListCoordinator.swift
//  BDD
//
//  Created by Alexandre Scheer Bing on 05/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import UIKit


class ConsultListCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.childCoordinators = []
    }
    func start() {
        if let mainVC = UIStoryboard(name: "ConsultList", bundle: nil).instantiateViewController(withIdentifier: "ConsultList")
            as? UIViewController {
            
            //mainVC.delegate = self
            mainVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
            presenter.setViewControllers([mainVC], animated: true)
        }
    }
    
    func back(selectedCurrency: CurrencyCellViewData){
        if let mainVC =  presenter.viewControllers.first as? NewConsultViewController{
            
            
            
            mainVC.mySelectedCurrency = selectedCurrency // Adiciona a moeda selecionada na variavel da tela anterior
            mainVC.selectedCurrenciesCollection.reloadData() // Atualiza a collectionView
            presenter.popViewController(animated: true)
            
            
        }
    }
}
